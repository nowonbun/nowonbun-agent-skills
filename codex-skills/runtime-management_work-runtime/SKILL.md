---
name: work-runtime
description: Agents executing harness workflows must use this runtime rule to apply shared trigger, validation, stop, reporting, and text-write controls.
---

# Work Runtime

# Must

## Scope
- You must apply this document when executing shared runtime controls delegated by `AGENTS` inside this harness.
- You must treat this document as the single source of truth for shared trigger precedence, shared review references, shared MCP pre-validation, shared stop conditions, shared report formats, and shared text-document write verification delegated by `AGENTS`.
- You must not treat this document as the source of truth for workflow-specific execution orders, tool-specific parameter rules, or Claude review log schema.

## Source of Truth
- This document governs shared trigger precedence, shared review references, shared MCP pre-validation, shared stop conditions, shared report formats, and shared text-document write verification in `./SKILL.md`; it does not govern workflow-specific execution order, mandatory review-phase sequence design, or tool-specific parameter rules.
- `../skill-management_skill-modify-history/SKILL.md` is the single source of truth for mandatory review-phase requirements and daily-history trigger handling when rule documents are revised; consult it when deciding whether `plan-review`, `source-review`, `result-review`, `re-review`, or `history/skill_YYYYMMDD.md` is required, not for shared runtime trigger, stop, or report controls.
- `../runtime-management_claude-review-runtime/SKILL.md` is the single source of truth for Claude review startup, local preflight, and blocked-state handling; consult it when deciding how a required review phase must start or fail, not for shared runtime trigger, stop, or report controls.
- `../tool-usage-management_claude-cross-review-protocol/SKILL.md` is the single source of truth for Claude Collaboration Log fields and review normalization; consult it when deciding how review output must be recorded, not for shared runtime control delegation.
- `../runtime-management_markdown-safe-writing/SKILL.md` is the single source of truth for text-document corruption recovery and write-path safety decisions beyond the shared UTF-8 verification defined here; consult it when deciding recovery or incident-handling steps, not for shared stop/report controls.

## Shared Trigger Rules
- Exact trigger phrase matches must take precedence over non-exact or inferred matches.
- If two or more workflows define the same exact trigger phrase, execution must stop and a Stop-condition Confirmation Request must be issued.
- A workflow that requires a path-specific trigger must not run when the resolved target path falls outside the governed folder defined by `AGENTS`.

## Shared Review Reference Rules
- When a workflow revises rule documents, it must reference `../skill-management_skill-modify-history/SKILL.md` for mandatory review-phase requirements and daily-history trigger handling before and after write execution.
- When a workflow invokes Claude review phases, it must reference `../runtime-management_claude-review-runtime/SKILL.md` for review startup, local preflight, and blocked-state handling.
- When a workflow reports Claude review results, it must reference `../tool-usage-management_claude-cross-review-protocol/SKILL.md` for Claude Collaboration Log fields and normalized finding output.

## Shared MCP Pre-validation Rules
- Before any MCP tool call, the workflow must verify the source-of-truth file, ID, URL, or target reference required by that workflow.
- Before any MCP write operation, the workflow must validate parameter existence, format, and target-ID consistency for the selected server.
- If source verification or parameter validation cannot be completed, execution must stop before the MCP call.

## Shared Stop Conditions
- Execution must stop when a required input is missing.
- Execution must stop when a required input is ambiguous.
- Execution must stop when active rules conflict without a defined resolver.
- Execution must stop when a target path cannot be normalized to one canonical real path.
- Execution must stop when a write action would affect content outside the declared instruction scope.
- Execution must stop when a required source-of-truth file is missing, unreadable, or empty when delegated controls are required.

## Shared Report Format Rules

### Workflow Failure Report
- finding: what failed
- evidence: files, logs, or MCP responses that prove the failure
- next action: the next step, including the re-run condition

### Stop-condition Confirmation Request
- blocked by: the blocking rule or condition
- requested decision: the explicit user decision required to continue
- impact: the consequence of each available decision path

## Text-document Write Verification
- Text-document writes delegated by this workspace must use UTF-8.
- Post-write verification must check that the file can be read as UTF-8 and must separate console-rendering issues from file-content corruption.
- The same UTF-8 verification requirement applies to newly created companion readme files and history artifacts in the delegated workspace scope.

# Must NOT

## Scope Drift
- You must not define workflow-specific execution orders in this document.
- You must not redefine tool-specific parameter rules that belong to tool-usage skills.
- You must not redefine Claude review-phase sequence or Claude Collaboration Log schema when a referenced source-of-truth document already defines them.

## Trigger Execution
- You must not start an exact-match workflow from a partial, prefix-only, or inferred trigger.
- You must not run a path-scoped workflow after path normalization fails.

# Flow
1. Verify that `./SKILL.md` is readable before using delegated shared controls.
2. Apply shared trigger rules and path-boundary checks.
3. Apply shared review references when the workflow revises rule documents or invokes Claude review.
4. Apply shared MCP pre-validation before MCP calls.
5. Apply shared stop conditions before writes or other blocked actions proceed.
6. Apply shared report formats and UTF-8 verification before final reporting.

# Definition of Done

## Verification
- The document includes valid frontmatter with only `name` and `description`.
- Shared runtime controls delegated by `AGENTS` are covered without introducing workflow-specific execution orders.
- Shared review references point to `../skill-management_skill-modify-history/SKILL.md`, `../runtime-management_claude-review-runtime/SKILL.md`, and `../tool-usage-management_claude-cross-review-protocol/SKILL.md` without duplicating their rule text.
- Shared MCP pre-validation, stop-condition, report-format, and UTF-8 verification rules remain executable.
- The `# Must NOT` rules prevent scope drift and invalid trigger execution.
