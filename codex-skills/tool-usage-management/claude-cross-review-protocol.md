---
name: claude-cross-review-protocol
description: Agents that need Claude cross-review for changes must invoke Claude through MCP with deterministic review axes, normalized findings, and explicit adoption records.
---

# Claude Cross Review Protocol

# Must

## Scope
- You must apply this document when running Claude cross-review for code changes, document changes, configuration changes, rule-document changes, or workflow-design changes.
- You must apply this document to Claude cross-review invocation, review normalization, and review-log reporting.

## Source of Truth
- This document is the single source of truth for Claude cross-review invocation, normalization, and reporting format.
- `../runtime-management/ai-collaboration-governance.md` is the single source of truth for Claude collaboration runtime controls, timeout handling, fallback flow, and prompt-size control.
- `../skill-management/skill-modify-history.md` is the single source of truth for history-record obligations when rule documents are revised.
- `D:/work/nowonbun-harness/CLAUDE.md` is the single source of truth for review-policy profile content and review priorities.

## Source Availability Rules
- Before invocation, you must verify readability of every source-of-truth document required for the current review step.
- When a required source-of-truth document is unreadable or missing, you must stop cross-review and report `cross-review: blocked (reason: source-of-truth unavailable)`.
- When cross-review is blocked by source-of-truth unavailability, you must request user decision before resuming.

## Pre-Review Input Rules
- Before invoking Claude, you must define the review phase as one of `plan-review`, `source-review`, `result-review`, or `re-review`.
- Before invoking Claude, you must define one explicit review objective.
- Before invoking Claude, you must define target file paths.
- Before invoking Claude, you must define acceptance criteria.
- Before invoking Claude, you must define exclusion scope.
- Before invoking Claude, you must define agreed-items baseline that can be omitted from review output.
- Before invoking Claude, you must confirm that all target paths are readable.
- Before invoking Claude, you must confirm readability of `../runtime-management/ai-collaboration-governance.md`.
- Before invoking Claude, you must confirm readability of `D:/work/nowonbun-harness/CLAUDE.md`.
- When review-policy source verification fails, you must stop cross-review and record `cross-review: blocked (reason: review policy unavailable)`.
- When runtime-governance source verification fails, you must stop cross-review and record `cross-review: blocked (reason: runtime governance unavailable)`.
- When at least one target path is unreadable, you must stop cross-review and record `cross-review: blocked (reason: unreadable path)`.

## Review Focus Rules
- You must review only these mandatory axes unless the objective explicitly adds more axes:
  - consistency
  - degradation risk
  - regression risk
  - scope integrity
  - evidence sufficiency
- When the target includes text documents, you must add UTF-8 integrity and text-preservation checks.
- You must omit commentary on already-agreed items when no new risk or contradiction is introduced.
- You must escalate a finding as NG when at least one mandatory axis fails.

## Invocation Rules
- You must run one review objective per Claude invocation.
- You must include review phase, objective, target paths, acceptance criteria, exclusion scope, agreed-items baseline, and mandatory review axes in each Claude request.
- You must instruct Claude to return NG-only output and omit agreed items without new risk.
- You must record invocation timestamp in ISO 8601 format.
- You must record input summary for each invocation.
- You must use the review-policy priorities defined in `D:/work/nowonbun-harness/CLAUDE.md` and must not substitute another review-policy file.
- You must follow timeout, fallback, and prompt-size controls defined in `../runtime-management/ai-collaboration-governance.md`.
- You must invoke Claude through `mcp_servers.nowonbun_claude` and must not substitute CLI entry points inside this harness.
- When Claude invocation fails because of timeout, transport failure, or MCP error, you must apply retry and fallback rules from `../runtime-management/ai-collaboration-governance.md`.

## Review Normalization Rules
- You must normalize each Claude finding into these fields: `status`, `severity`, `finding`, `evidence`, `recommendation`, and `decision`.
- Allowed status values are `verified`, `unverified`, and `error`.
- `error` means invocation-level or tool-level failure that prevents finding verification, and it must not be used for a confirmed defect finding.
- Allowed severity values are `Critical`, `High`, `Medium`, and `Low`.
- Allowed decision values are `adopted`, `rejected`, `deferred`, and `pending`.
- You must mark unverifiable statements as `unverified`.
- You must attach at least one evidence source for each verified finding.
- For error findings, you must attach failure evidence from execution output or tool response when available; if unavailable, you must record `evidence: unavailable` with failure reason.
- You must preserve rejected findings with rejection reason.
- You must set `decision: rejected` for all NG findings until a corrective patch is verified.

## Review Log Format Rules
- You must report cross-review results under a dedicated `Claude Collaboration Log` section.
- A Claude Collaboration Log entry must include these fields:
  - timestamp
  - phase
  - objective
  - target paths
  - mandatory axes
  - input summary
  - claude response summary
  - adoption decision
  - adoption reason
- `claude response summary` must be one sentence, must be 200 characters or fewer, and must include NG count and adoption conclusion.
- When NG count is zero, you must use `claude response summary: OK, no NG findings, agreed items omitted.`
- When cross-review is blocked, you must report `cross-review: blocked` and the explicit block reason.
- After each invocation, skip event, or blocked event, you must provide a user-facing conversation summary that includes `phase`, `cross-review status`, `summary`, `key findings`, and `next action`.

## Output Rules
- You must produce normalized finding records for each Claude invocation.
- You must produce one Claude Collaboration Log entry for each invocation or blocked event.
- When NG findings exist, you must output only NG findings using this compact line format: `NG|<severity>|<path:line>|<failed-axis>|<fix>`.
- When NG findings do not exist, you must output only `OK|no-ng|agreed-items-omitted`.
- For `plan-review`, you must treat the plan itself as the review target even when no file diff exists yet.
- For `source-review`, you must treat the modified source files and claimed invariants as the review target.
- For `result-review`, you must treat the produced changes and claimed execution result as the review target.
- For `re-review`, you must compare the latest corrective result against the previous NG findings.
- When findings cause file changes, you must update the corresponding history artifacts required by active source-of-truth rules.

# Must NOT

## Prohibited Review Behavior
- You must not apply Claude suggestions directly without local evidence verification.
- You must not merge `error` and `unverified` statuses into one status.
- You must not use values outside the allowed sets defined in `## Review Normalization Rules`.
- You must not omit rejection reasons for non-adopted Claude findings.
- You must not claim cross-review completion when required log fields are missing.
- You must not restate agreed items in review output unless new risk or contradiction is detected.

# Flow

## Claude Cross-Review Flow
1. Verify source-of-truth readability required for this run.
2. Define review phase, objective, target paths, acceptance criteria, exclusion scope, and agreed-items baseline.
3. Define mandatory review axes and add UTF-8 integrity checks when text documents are in scope.
4. Verify runtime-governance readability and apply its prompt-size and timeout controls before invocation.
5. If a required source document or target path is unreadable, stop and record `cross-review: blocked` with reason.
6. Invoke Claude through `mcp_servers.nowonbun_claude` with one objective and explicit NG-only instruction.
7. If invocation fails, apply retry and fallback rules from `../runtime-management/ai-collaboration-governance.md`.
8. Normalize Claude findings into required fields and allowed values.
9. Verify evidence for each finding and mark unverifiable items as `unverified`.
10. Decide adoption status for each finding and record reasons.
11. Write the Claude Collaboration Log entry, compact NG/OK output, and user-facing conversation summary.
12. Update required history artifacts when review results changed files.

# Definition of Done

## Verification
- Rules in `## Source Availability Rules` are satisfied before invocation.
- Rules in `## Pre-Review Input Rules` are satisfied before invocation.
- Rules in `## Review Focus Rules` are satisfied for each invocation.
- Rules in `## Invocation Rules` are satisfied for each invocation.
- Rules in `## Review Normalization Rules` are satisfied for each finding.
- Rules in `## Review Log Format Rules` are satisfied for each invocation, skip event, or blocked event.
- Phase-specific handling for `plan-review`, `source-review`, `result-review`, and `re-review` is satisfied.
- Rules in `## Output Rules` are satisfied, including history updates when required.
- No prohibited behavior in `# Must NOT` occurred during execution.
