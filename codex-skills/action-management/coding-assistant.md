---
name: coding-assistant
description: Engineers handling coding changes must use this skill to classify change risk, coordinate Codex and Claude review, and report verification results consistently.
---

# Coding Assistant Skill

# Must

## Scope
- You must apply this document when handling code, configuration, or developer-document changes that need implementation planning, review, or verification.
- You must apply the same review discipline to documentation and configuration changes when they can affect execution behavior.

## Source of Truth
- This document is the single source of truth for coding-change coordination in `codex-skills/action-management/coding-assistant.md`.
- `../runtime-management/claude-review-runtime.md` is the single source of truth for Claude review runtime applicability, fallback, and execution handling.
- `../tool-usage-management/claude-cross-review-protocol.md` is the single source of truth for Claude review output format and review-log schema.

## Change Classification Rules
- You must classify each request as non-destructive or destructive before implementation.
- You must treat schema changes, API contract changes, authentication or permission changes, large deletions, and workflow-breaking configuration changes as destructive.
- You must document the approval requirement that follows from the classification.

## Role Allocation Rules
- Codex must own requirement breakdown, implementation plan, change execution, and final integration.
- Claude review must own independent review, source investigation, and verification suggestions when Claude review is available and applicable.
- You must keep review independent when the task requires high-risk or policy-sensitive verification.

## Approval and Execution Rules
- You must obtain user confirmation before destructive changes.
- You must present the planned file scope and expected impact before executing a destructive change.
- You must state the evidence path when MCP, issue history, database state, or external documentation is required.

## Claude Review Rules
- You must run Claude review as a mandatory gate for coding, configuration, and execution-affecting documentation changes.
- You must run `plan-review` before execution starts when an actionable plan exists.
- You must run `source-review` after source changes exist and before completion reporting.
- You must run `result-review` after execution results and verification evidence are available.
- When Claude review is run, you must follow `../runtime-management/claude-review-runtime.md` for availability checks, fallback handling, and escalation behavior.
- When Claude review is unavailable or fails, you must switch to an explicit alternative verification flow instead of silently skipping review.

## Alternative Verification Rules
- You must separate policy review, implementation review, and command validation when Claude review is unavailable.
- You must record executed commands separately from proposed commands.
- You must record remaining risks when review depth is lower than planned.

## Final Reporting Rules
- You must report changed files, key modifications, impact scope, verification commands, and remaining issues.
- You must report whether Claude review was attempted, which review execution path was used, and whether fallback verification was used.
- You must distinguish verified facts from unverified assumptions in the final report.

# Must NOT

## Prohibited Collaboration Behavior
- You must not implement destructive changes before user approval.
- You must not present Claude review as completed when only a plan exists.
- You must not hide review failure, timeout, or fallback execution.
- You must not merge implementation conclusions and independent review conclusions into one unlabeled block.
- You must not treat configuration or documentation changes as no-review changes when they alter execution behavior.

# Flow

## Change Handling Flow
1. Classify the request as non-destructive or destructive.
2. Define target files, expected impact, and approval requirement.
3. Prepare the mandatory review sequence.
4. Run `plan-review`.
5. Execute implementation planning and changes through Codex.
6. Run `source-review` and `result-review`, or explicit blocked/fallback handling when Claude review cannot complete.
7. Report changed files, verification evidence, review result, and remaining risks.

# Definition of Done

## Verification
- Change classification and approval requirement are documented.
- Codex and Claude responsibilities are separated.
- Destructive changes are blocked until user approval is obtained.
- Mandatory review phases or blocked/fallback handling are recorded.
- Final report includes changed files, impact scope, verification commands, and remaining risks.
