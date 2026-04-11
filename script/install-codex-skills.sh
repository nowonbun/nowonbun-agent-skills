#!/usr/bin/env bash

set -euo pipefail

# ===== Configuration =====
# - SOURCE_ROOT: repository root path
#   example) D:/work/nowonbun-agent-skills
# - SKILL_SOURCE_DIR: skill source folder relative to SOURCE_ROOT (default: codex-skills)
#   example) codex-skills
# - Every .md file under nested folders is treated as a skill.
#   example) codex-skills/test1/test2/abc.md
#     -> .codex/skills/test1_test2_abc/SKILL.md
# - TARGET_DIR: parent root of the .codex directory
#   example) /Users/nowonbun

TARGET_DIR="${TARGET_DIR:-$HOME/workspace-target}"
SOURCE_ROOT="${SOURCE_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
SKILL_SOURCE_DIR="${SKILL_SOURCE_DIR:-codex-skills}"

if [[ "$SKILL_SOURCE_DIR" = /* ]] || [[ "$SKILL_SOURCE_DIR" =~ ^[A-Za-z]:[\\/].* ]]; then
    SKILL_SOURCE_ROOT="$SKILL_SOURCE_DIR"
else
    SKILL_SOURCE_ROOT="$SOURCE_ROOT/$SKILL_SOURCE_DIR"
fi

CODEX_ROOT="$TARGET_DIR/.codex"
SKILLS_ROOT="$CODEX_ROOT/skills"
CONFIG_PATH="$CODEX_ROOT/config.toml"
MANIFEST_PATH="$CODEX_ROOT/install-codex-skills.manifest.txt"

test_skill_sheet() {
    local file_path="$1"

    awk '
        BEGIN { in_frontmatter=0; first_delim=0; has_name=0; has_desc=0 }
        NR == 1 && $0 ~ /^---[[:space:]]*$/ { in_frontmatter=1; first_delim=1; next }
        in_frontmatter && $0 ~ /^---[[:space:]]*$/ {
            exit(first_delim && has_name && has_desc ? 0 : 1)
        }
        in_frontmatter && $0 ~ /^[[:space:]]*name[[:space:]]*:/ { has_name=1 }
        in_frontmatter && $0 ~ /^[[:space:]]*description[[:space:]]*:/ { has_desc=1 }
        END {
            if (!(first_delim && has_name && has_desc)) {
                exit 1
            }
        }
    ' "$file_path"
}

normalize_skill_name() {
    local relative_path="$1"
    local without_extension="${relative_path%.md}"
    local normalized

    normalized="$(printf '%s' "$without_extension" | sed -E 's#[/\\]+#_#g; s#[[:space:]]+#_#g; s#^[_\.]+##; s#[_\.]+$##')"

    if [[ -z "$normalized" ]]; then
        echo "Cannot convert path to skill name. relativePath=$relative_path" >&2
        exit 1
    fi

    printf '%s\n' "$normalized"
}

load_previous_skill_names() {
    if [[ ! -f "$MANIFEST_PATH" ]]; then
        return 0
    fi

    sed '/^[[:space:]]*$/d' "$MANIFEST_PATH"
}

save_current_skill_names() {
    local tmp_manifest
    tmp_manifest="$(mktemp)"

    if ((${#SKILL_NAMES[@]} > 0)); then
        printf '%s\n' "${SKILL_NAMES[@]}" | sort -u > "$tmp_manifest"
    fi

    mkdir -p "$CODEX_ROOT"
    cp "$tmp_manifest" "$MANIFEST_PATH"
    rm -f "$tmp_manifest"
}

remove_stale_skill_dirs() {
    local -A current_skill_set=()
    local old_name stale_dir

    for old_name in "${SKILL_NAMES[@]}"; do
        current_skill_set["$old_name"]=1
    done

    while IFS= read -r old_name; do
        [[ -z "$old_name" ]] && continue
        if [[ -n "${current_skill_set[$old_name]:-}" ]]; then
            continue
        fi

        stale_dir="$SKILLS_ROOT/$old_name"
        if [[ -d "$stale_dir" ]]; then
            rm -rf "$stale_dir"
            echo "[DEL ] Removed previously managed skill: $stale_dir"
        fi
    done < <(load_previous_skill_names)
}

rewrite_skill_config() {
    local tmp_config old_config managed_prefix line current_block block_path normalized_path
    tmp_config="$(mktemp)"
    old_config="$(mktemp)"
    managed_prefix="$SKILLS_ROOT/"

    mkdir -p "$CODEX_ROOT"
    touch "$CONFIG_PATH"
    cp "$CONFIG_PATH" "$old_config"

    current_block=()

    flush_block() {
        if ((${#current_block[@]} == 0)); then
            return
        fi

        block_path=""
        for line in "${current_block[@]}"; do
            if [[ "$line" =~ ^[[:space:]]*path[[:space:]]*=[[:space:]]*"(.*)"[[:space:]]*$ ]]; then
                block_path="${BASH_REMATCH[1]}"
                break
            fi
        done

        normalized_path="${block_path//\\//}"
        if [[ -n "$normalized_path" && "$normalized_path" == "$managed_prefix"* ]]; then
            current_block=()
            return
        fi

        printf '%s\n' "${current_block[@]}" >> "$tmp_config"
        current_block=()
    }

    while IFS= read -r line || [[ -n "$line" ]]; do
        if ((${#current_block[@]} > 0)); then
            if [[ "$line" == \[\[* ]]; then
                flush_block
                if [[ "$line" == '[[skills.config]]' ]]; then
                    current_block=("$line")
                else
                    printf '%s\n' "$line" >> "$tmp_config"
                fi
            else
                current_block+=("$line")
            fi
            continue
        fi

        if [[ "$line" == '[[skills.config]]' ]]; then
            current_block=("$line")
        else
            printf '%s\n' "$line" >> "$tmp_config"
        fi
    done < "$old_config"

    flush_block

    python - <<'PY' "$tmp_config"
from pathlib import Path
import sys
path = Path(sys.argv[1])
text = path.read_text(encoding='utf-8', errors='ignore')
text = text.rstrip('\n')
if text:
    text += '\n'
path.write_text(text, encoding='utf-8')
PY

    for skill_name in "${SKILL_NAMES[@]}"; do
        skill_path="$SKILLS_ROOT/$skill_name/SKILL.md"
        {
            if [[ -s "$tmp_config" ]]; then
                printf '\n'
            fi
            printf '[[skills.config]]\n'
            printf 'path = "%s"\n' "$skill_path"
            printf 'enabled = true\n'
        } >> "$tmp_config"
        echo "[ADD ] config.toml entry: $skill_path"
    done

    cp "$tmp_config" "$CONFIG_PATH"
    rm -f "$tmp_config" "$old_config"
}

if [[ ! -d "$SKILL_SOURCE_ROOT" ]]; then
    echo "Skill source root not found. expected=$SKILL_SOURCE_ROOT" >&2
    exit 1
fi

mkdir -p "$SKILLS_ROOT"

declare -a SKILL_FILES=()
declare -a SKILL_NAMES=()
declare -A SKILL_NAME_SEEN=()

while IFS= read -r file_path; do
    if ! test_skill_sheet "$file_path"; then
        continue
    fi

    relative_path="${file_path#"$SKILL_SOURCE_ROOT"/}"
    skill_name="$(normalize_skill_name "$relative_path")"

    if [[ -n "${SKILL_NAME_SEEN[$skill_name]:-}" ]]; then
        echo "Duplicate skill name detected. $skill_name" >&2
        echo "- ${SKILL_NAME_SEEN[$skill_name]}" >&2
        echo "- $relative_path" >&2
        exit 1
    fi

    SKILL_NAME_SEEN["$skill_name"]="$relative_path"
    SKILL_FILES+=("$file_path")
    SKILL_NAMES+=("$skill_name")
done < <(find "$SKILL_SOURCE_ROOT" -type f -name '*.md' | sort)

if ((${#SKILL_FILES[@]} == 0)); then
    echo "No skill sheet with metadata (name, description) found. skillSourceRoot=$SKILL_SOURCE_ROOT" >&2
    exit 1
fi

remove_stale_skill_dirs

for i in "${!SKILL_FILES[@]}"; do
    file_path="${SKILL_FILES[$i]}"
    skill_name="${SKILL_NAMES[$i]}"
    relative_path="${file_path#"$SKILL_SOURCE_ROOT"/}"
    skill_dir="$SKILLS_ROOT/$skill_name"
    skill_target_path="$skill_dir/SKILL.md"

    mkdir -p "$skill_dir"
    cp "$file_path" "$skill_target_path"
    echo "[COPY] ${relative_path} -> ${skill_target_path}"
done

rewrite_skill_config
save_current_skill_names

echo
echo "Done:"
echo "- sourceRoot     : $SOURCE_ROOT"
echo "- skillSourceRoot: $SKILL_SOURCE_ROOT"
echo "- targetDir      : $TARGET_DIR"
echo "- config         : $CONFIG_PATH"
