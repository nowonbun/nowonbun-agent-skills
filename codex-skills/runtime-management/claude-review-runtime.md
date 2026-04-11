---
name: claude-review-runtime
description: Agents that need to run Claude CLI cross-review must use this runtime skill to decide applicability, perform local preflight, and hand off execution to the Claude cross-review protocol.
---

# Claude Review Runtime

# Must

## Scope
- You must apply this document when the task requires Claude CLI cross-review for code, document, configuration, or rule changes.
- You must treat this document as the runtime-entry wrapper for Claude review execution, not as the single source of truth for review-log structure or finding normalization.

## Applicability Rules
- You must use this document for every task that changes code, documents, configuration, rule documents, or workflow definitions inside the governed harness scope.
- You must classify the review phase as `plan-review`, `source-review`, `result-review`, or `re-review` before invocation.
- `plan-review` means the first review that occurs after an actionable implementation plan is prepared and before execution starts.
- `source-review` means the review that occurs after source modifications exist and before final completion reporting.
- `result-review` means the review that occurs after execution produced a concrete result such as file changes, document changes, configuration changes, or rule changes.
- `re-review` means a repeated review that occurs after corrective changes were applied in response to an earlier Claude finding.
- When a task includes planning and execution, you must run `plan-review` first.
- When a task changes source files, you must run `source-review` before completion reporting.
- When execution produced a concrete result, you must run `result-review` after the result is available.
- When no actionable plan exists yet, you must stop review startup and report `cross-review: blocked (reason: no actionable plan)`.

## Source of Truth
- `../tool-usage-management/claude-cross-review-protocol.md` is the single source of truth for Claude invocation structure, mandatory review axes, finding normalization, and collaboration log format.
- `../skill-management/skill-modify-history.md` is the single source of truth for history-record obligations when revising this runtime skill or the protocol.

## Local Preflight Rules
- Before invoking Claude CLI, you must verify that `claude.cmd` is callable in the current environment.
- Before invoking Claude CLI, you must run a minimal responsiveness check that expects `OK` as the exact output.
- When the CLI version check fails, you must stop Claude review and report `cross-review: blocked (reason: claude cli unavailable)`.
- When the responsiveness check fails, you must stop Claude review and report `cross-review: blocked (reason: claude cli unresponsive)`.

## Input Preparation Rules
- Before invoking Claude, you must define the current review phase.
- You must prepare the review objective and target paths before calling the protocol flow.
- For `plan-review`, you must include the implementation plan, intended scope, acceptance criteria, and excluded work in the review objective.
- For `source-review`, you must include changed source paths, diff scope summary, expected invariants, and unresolved risks in the review objective.
- For `result-review`, you must include changed paths, claimed results, verification results if available, and known limitations in the review objective.
- For `re-review`, you must include the previous NG summary, corrective changes, and unresolved items in the review objective.
- When the target includes `.md`, `.txt`, or other text documents, you must add UTF-8 integrity and text-preservation checks to the review objective.
- You must keep the prompt body short enough to avoid command-line length overflow.
- You must pass file paths and review intent, and must not paste full diffs or full file contents into the CLI argument when direct file reading is sufficient.

## Execution Rules
- After local preflight succeeds, you must follow `../tool-usage-management/claude-cross-review-protocol.md` for the actual Claude invocation and reporting.
- You must use `claude.cmd` instead of `claude.ps1` unless the environment explicitly requires another entry point.
- When invocation failure occurs, you must follow the retry and blocked-state rules defined in `../tool-usage-management/claude-cross-review-protocol.md`.
- After each `plan-review`, `source-review`, `result-review`, or `re-review`, you must report the review result to the user in the active conversation.
- The user-facing report must include `phase`, `cross-review status`, `summary`, `key findings`, and `next action`.

# Must NOT

## Prohibited Behavior
- You must not redefine finding normalization rules that already belong to `../tool-usage-management/claude-cross-review-protocol.md`.
- You must not redefine collaboration log format that already belongs to `../tool-usage-management/claude-cross-review-protocol.md`.
- You must not skip local CLI availability checks when this runtime skill is the selected execution entry.
- You must not send full diff payloads or full file bodies through the CLI argument when target files are locally readable.

# Flow

## Claude Review Entry Flow
1. Decide the mandatory review phase sequence under `## Applicability Rules`.
2. Classify the review phase as `plan-review`, `source-review`, `result-review`, or `re-review`.
3. Run the local CLI version and responsiveness checks.
4. Prepare the review objective, target paths, and document-integrity checks when applicable.
5. Hand off execution to `../tool-usage-management/claude-cross-review-protocol.md`.
6. Report the result using the protocol-defined output and log format, and also provide the required user-facing conversation summary.

# Definition of Done

## Verification
- Mandatory applicability was decided under `## Applicability Rules`.
- Review phase was classified before invocation.
- Local CLI preflight succeeded before protocol handoff, or a blocked result was reported.
- Text-document review objectives include UTF-8 integrity and text-preservation checks when applicable.
- Invocation, normalization, and reporting rules were delegated to `../tool-usage-management/claude-cross-review-protocol.md` without duplicate local rule text.
- User-facing review summary was reported for each mandatory review phase.
- No prohibited behavior in `# Must NOT` occurred during execution.
