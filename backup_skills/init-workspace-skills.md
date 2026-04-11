---
name: init-workspace-skills
description: 워크스페이스나 프로젝트에 공통 지침과 스킬 시트를 초기화하거나 업데이트할 때 사용한다. global_instructions.md를 프로젝트 루트로 복사하고, 각 스킬 시트는 Codex와 Claude의 스킬 경로로 복사하며, 복사된 위치에 맞게 문서 내부 경로와 설정 경로를 수정한다.
---

# Init Workspace Skills Skill

## 목적
중앙 스킬 저장소의 `global_instructions.md`와 각 스킬 시트를 워크스페이스 또는 프로젝트 기준 위치로 초기화하고, 이후 업데이트 시 같은 규칙으로 덮어쓰기하는 절차를 고정한다.

## 규칙
1. 소스 저장소는 기본적으로 `D:/work/nownobun-agent-skills`로 본다.
2. `D:/work/nownobun-agent-skills/global_instructions.md`는 대상 프로젝트의 루트에 `global_instructions.md`로 복사한다.
3. 소스 저장소의 각 스킬 시트(`*.md`)는 아래 대상 경로로 복사한다.
   - Codex: `~/.codex/skills/<파일명에서 .md 제거>/SKILL.md`
   - Claude 기본 경로: `~/.claude/skills/<파일명에서 .md 제거>/SKILL.md`
   - Claude 사용자 지정 경로: `~/.claude/skils/<파일명에서 .md 제거>/SKILL.md`
   - Claude 경로 선택은 한 번의 실행에서 하나만 사용한다.
   - Claude 경로 선택 우선순위는 아래와 같다.
     1. 사용자가 명시한 경로
     2. 사용자 명시가 없고 `~/.claude/skills/`는 없으며 `~/.claude/skils/`만 존재하는 경우 그 경로
     3. 그 외에는 기본값 `~/.claude/skills/`
4. 스킬 디렉터리명은 원본 파일명에서 확장자 `.md`를 제거한 값과 일치해야 한다. 예: `ai-agent.md` -> `~/.codex/skills/ai-agent/SKILL.md`, `~/.claude/skills/ai-agent/SKILL.md`
5. 복사 대상 스킬 시트에는 `global_instructions.md`와 `CLAUDE.md`는 포함하지 않는다. 단, `CLAUDE.md`는 Claude Code가 프로젝트 루트에서 자동으로 읽으므로 별도 배포 없이 소스 저장소에서 관리한다.
6. 복사 후에는 각 파일 내부에 남아 있는 원본 저장소 경로를 복사된 위치 기준 경로로 수정한다.
7. 경로 수정 대상에는 원본 저장소 경로의 슬래시 표기 변형(`/` 및 `\`)이 모두 포함되어야 한다. 최소한 아래를 치환 대상으로 본다.
   - `D:/work/nownobun-agent-skills/global_instructions.md`
   - `D:/work/nownobun-agent-skills/<skill>.md`
   - `D:\work\nownobun-agent-skills\global_instructions.md`
   - `D:\work\nownobun-agent-skills\<skill>.md`
8. 스킬 시트 안에서 다른 스킬 시트를 참조하는 경로는 복사된 경로 기준으로 바꾼다.
   - Codex 기준: `~/.codex/skills/<대상스킬>/SKILL.md`
   - Claude 기본 기준: `~/.claude/skills/<대상스킬>/SKILL.md`
   - Claude 사용자 지정 경로를 선택한 경우: `~/.claude/skils/<대상스킬>/SKILL.md`
9. 설정 파일 반영 대상은 프로젝트 하위 `.codex/config.toml`가 아니라 사용자 홈 경로의 설정 파일로 본다.
   - Codex: `~/.codex/config.toml`
   - Claude 설정 파일은 이 문서에서 표준 경로를 정의하지 않는다.
   - Claude 설정 파일 수정은 사용자가 실제 파일 경로를 명시했을 때만 수행한다.
10. `~/.codex/config.toml`이 존재하면 아래를 함께 수정한다.
   - `model_instructions_file`은 프로젝트 루트에 복사된 `global_instructions.md` 경로로 맞춘다.
   - 스킬 경로 설정은 `~/.codex/skills/<스킬명>/SKILL.md` 기준으로 맞춘다.
11. 사용자가 Claude 설정 파일 경로를 명시한 경우에만 아래를 함께 수정한다.
   - 선택된 Claude 스킬 경로(`~/.claude/skills/...` 또는 `~/.claude/skils/...`)를 가리키도록 맞춘다.
   - 경로를 명시하지 않았으면 Claude 설정 파일 수정은 생략한다.
12. 사용자가 "초기화"를 말하면 대상 파일이 없어도 생성한다.
13. 사용자가 "업데이트"를 말하면 기존 파일을 같은 규칙으로 덮어쓴다.
14. 업데이트 시 기존에 복사되어 있는 파일 내용은 보존하지 않는다. 원본 시트를 기준으로 다시 복사하고 경로를 다시 치환한다.
15. 복사와 경로 수정 후에는 최소한 아래를 검증한다.
   - 프로젝트 루트의 `global_instructions.md` 존재 여부
   - `~/.codex/skills/<스킬명>/SKILL.md` 존재 여부
   - 선택된 Claude 경로의 `SKILL.md` 존재 여부
   - 문서 내부에 원본 경로가 남아 있는지 여부
   - `~/.codex/config.toml` 경로 반영 여부
   - 사용자가 Claude 설정 파일 경로를 명시한 경우 그 반영 여부
16. `markdown-safe-writing.md`는 기본 배포 목록에 항상 포함한다.

## 절차
1. 대상 프로젝트 루트 경로를 확인한다.
2. `global_instructions.md`를 프로젝트 루트로 복사한다.
3. 복사할 스킬 시트 목록을 정한다.
4. 각 스킬 시트마다 아래 디렉터리를 만든다.
   - `~/.codex/skills/<스킬명>/`
   - 선택된 Claude 경로의 `<스킬명>/`
5. 각 스킬 시트를 각 디렉터리의 `SKILL.md`로 복사한다.
6. 복사된 `global_instructions.md`와 각 `SKILL.md` 안의 경로를 새 위치 기준으로 수정한다.
7. `~/.codex/config.toml`이 있으면 `model_instructions_file`과 스킬 경로를 수정한다.
8. 사용자가 Claude 설정 파일 경로를 명시했으면 해당 Claude 설정 파일 안의 스킬 경로도 수정한다.
9. 사용자가 업데이트를 요청한 경우에도 위 절차를 동일하게 반복하고 기존 파일은 덮어쓴다.
10. 기본 배포 목록에는 문서 작성 안전 규칙 스킬 `markdown-safe-writing.md`를 항상 포함한다.

## 산출물 형식
- 프로젝트 루트: `global_instructions.md`
- Codex 사용자 홈 스킬 경로: `~/.codex/skills/<스킬명>/SKILL.md`
- Claude 사용자 홈 스킬 경로: 기본 `~/.claude/skills/<스킬명>/SKILL.md`
- Claude 사용자 지정 경로: 필요 시 `~/.claude/skils/<스킬명>/SKILL.md`
- 설정 반영 대상: `~/.codex/config.toml`
- Claude 설정 반영 대상: 사용자가 경로를 명시한 경우에 한해 해당 파일

## 예시 매핑
- `D:/work/nownobun-agent-skills/ai-agent.md`
  -> Codex: `~/.codex/skills/ai-agent/SKILL.md`
  -> Claude 기본: `~/.claude/skills/ai-agent/SKILL.md`
  -> Claude 사용자 지정 시 대체: `~/.claude/skils/ai-agent/SKILL.md`
- `D:/work/nownobun-agent-skills/coding-assistant.md`
  -> Codex: `~/.codex/skills/coding-assistant/SKILL.md`
  -> Claude 기본: `~/.claude/skills/coding-assistant/SKILL.md`
  -> Claude 사용자 지정 시 대체: `~/.claude/skils/coding-assistant/SKILL.md`
- `D:/work/nowonbun-harness/codex-skills/runtime-management/markdown-safe-writing.md`
  -> Codex: `~/.codex/skills/markdown-safe-writing/SKILL.md`
  -> Claude 기본: `~/.claude/skills/markdown-safe-writing/SKILL.md`
  -> Claude 사용자 지정 시 대체: `~/.claude/skils/markdown-safe-writing/SKILL.md`

## ???? ?? ???
- ?? ?????? ??? `script/install-codex-skills.ps1`, `script/install-codex-skills.sh` ??? ????.
- ????? `D:/work/nownobun-agent-skills` ??? ?? `*.md` ??? ????.
- `name`, `description` ???? ?? ??? ?? ??? ????.
- ?? ????? ??? ?? ???? ????.
- ?? ??? `?? ????/.codex/skills/<???>/SKILL.md` ??.
- ????? `?? ????/.codex/config.toml` ? `[[skills.config]]`? ?? ?? ????.

- ????? `?? ????/.codex/config.toml` ? `path` ?? ?? ?? ?? ??? ????.
  ```toml
  [[skills.config]]
  path = "..."
  enabled = true
  ```
