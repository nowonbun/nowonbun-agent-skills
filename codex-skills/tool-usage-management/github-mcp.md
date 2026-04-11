---
name: github-mcp
description: Engineers using GitHub MCP must use this skill to separate GitHub API actions from git CLI work and validate repository target identifiers before write operations.
---

# GitHub MCP Skill

# Must

## Scope
- You must apply this document when using GitHub MCP tools for repository, issue, pull-request, review, branch, file, or comment operations.
- You must treat GitHub MCP as remote GitHub API access, not as a replacement for local git CLI commit and push operations.

## Source of Truth
- This document is the single source of truth for GitHub MCP usage rules in `codex-skills/tool-usage-management/github-mcp.md`.
- `D:/work/nowonbun-harness/AGENTS.md` and `codex-skills/runtime-management/work-runtime.md` are the single source of truth for shared MCP pre-validation and stop conditions.

## Operation Boundary Rules
- You must use git CLI for local staging, commit, diff, and push operations.
- You must use GitHub MCP for remote GitHub state such as issues, pull requests, review comments, branches, releases, repository files, and metadata.
- You must state which part of the task is local git work and which part is GitHub MCP work before execution when both are involved.

## Target Validation Rules
- Before any GitHub MCP write operation, you must verify `owner`, `repo`, and target identifier fields required by the selected tool.
- You must validate pull-request numbers, issue numbers, branch names, comment IDs, and file paths against the intended repository scope before writing.
- You must verify that the selected write target matches the user request and current repository context.

## Read-Before-Write Rules
- Before adding review comments, replies, issue comments, PR updates, or merges, you must read the relevant issue, pull request, review thread, or file metadata when the current state is required for correctness.
- Before file creation or update through GitHub MCP, you must verify branch name and existing file SHA when the target file already exists.
- Before destructive remote actions such as closing issues, merging pull requests, deleting files, or changing branch targets, you must confirm that the action is in scope and reversible status is understood.

## Reporting Rules
- After GitHub MCP write operations, you must report the repository target, execution result, failure reason if any, and re-run necessity.
- You must distinguish remote GitHub changes from local workspace changes in the final report.
- You must mark assumptions as `unverified` when repository state could not be read directly.

# Must NOT

## Prohibited GitHub MCP Behavior
- You must not describe git commit or git push as GitHub MCP actions.
- You must not perform a GitHub MCP write with missing or mismatched repository identifiers.
- You must not skip pre-read state checks when correctness depends on current issue, PR, branch, or file state.
- You must not treat remote file deletion, PR merge, or issue closure as low-risk by default.

# Flow

## Execution Flow
1. Separate local git work from remote GitHub MCP work.
2. Identify the exact repository, branch, issue, PR, comment, or file target.
3. Read current GitHub state when required for correctness.
4. Validate all required write parameters for the selected tool.
5. Execute the GitHub MCP action.
6. Report target identifiers, result, failure reason, and re-run necessity.

# Definition of Done

## Verification
- Local git work and GitHub MCP work are explicitly separated.
- Required repository identifiers and target IDs are validated before writes.
- Read-before-write checks are performed when current state matters.
- Final report includes target identifier, execution result, failure reason if any, and re-run necessity.
