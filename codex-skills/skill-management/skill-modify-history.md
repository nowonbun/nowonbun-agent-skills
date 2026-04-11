---
name: skill-modify-history
description: Agents revising skill or governance documents after expectation mismatches must record cause, correction, and prevention details in deterministic history files.
---

# Skill Modify History

# Must

## Scope
- You must apply this document when user expectation and actual behavior differ, and the response requires revising skill, governance, or constitution rule documents.
- You must apply this document to history-record obligations and creation-time criteria, not to skill markdown format design.

## Source of Truth
- This document is the single source of truth for history-record obligations and day-based creation criteria.
- `skill-create-rule.md` is the single source of truth for skill-document structure, frontmatter, and companion-artifact requirements.

## History Artifact Types
- `daily history` means `history/skill_YYYYMMDD.md`.
- `skill-scoped history` means files under `history/<relative-skill-path>/<skill-name>/`.
- You must treat `daily history` and `skill-scoped history` as different artifact types.
- You must use `daily history` for day-level incident aggregation.
- You must use `skill-scoped history` for per-skill revision traceability.

## Daily History Trigger Rules
- Before editing any rule document, you must decide whether daily history creation is required.
- You must create `history/skill_YYYYMMDD.md` immediately when at least one trigger below is true:
  - skill list addition, deletion, or rename
  - skill description change
  - path-standard change
  - consistency-rule addition or modification
  - user-reported missing procedure
- When all triggers are false, you must record `daily-history-trigger: no-op` in the final execution report.

## Required Daily History Content
- A required daily history file must include these sections:
  - `Purpose`
  - `Incident Summary`
  - `Root Cause`
  - `Impact`
  - `Changes Applied`
  - `Recurrence Prevention Rules`
  - `Checklist`
  - `Conclusion`

## Recording Rules
- You must write one-line mismatch summary before writing detailed cause.
- You must separate "why it happened" and "what changed" into different sections.
- You must list exact modified file paths without abstraction.
- You must write recurrence-prevention rules as executable procedures.
- You must write checklist items that are reusable in the next similar task.
- You must save history files as UTF-8.
- You must not postpone required history creation to the final polishing phase.
- Before final reporting, you must cross-check `today's modified rule document list` against `today's generated history files`.

## Skill-Scoped History Language Rule
- When writing under `history/<relative-skill-path>/<skill-name>/`, you must use the same language as the latest existing history file in that folder.
- If no history file exists in that folder, you must use Korean.

## Cross-Review Requirement Rule
- You must run cross-review for every skill, governance, constitution, configuration, code, and document change covered by this harness.
- You must run `plan-review` after an actionable plan exists and before execution starts.
- You must run `source-review` when source files are modified and before final completion reporting.
- You must run `result-review` after execution produced a concrete result.
- You must run `re-review` after corrective changes were applied in response to a previous NG finding.
- You must report `cross-review: blocked` when mandatory cross-review cannot be completed.

## Outputs
- `history/skill_YYYYMMDD.md` when any daily-history trigger is true.
- Updated file list of modified rule documents.
- `daily-history-trigger: no-op` in the final execution report when all daily-history triggers are false.
- Cross-review result log when cross-review is required.

# Must NOT

## Prohibited Recording Behavior
- You must not close an incident record with only "it was a mistake".
- You must not omit modified file paths from history records.
- You must not finish a rule-document revision on a trigger-active day without creating `history/skill_YYYYMMDD.md`.
- You must not duplicate this document's history criteria as an independent rule set in other documents.

# Flow

## Incident Recording Flow
1. Summarize the expectation-versus-actual mismatch in one line.
2. Evaluate daily-history triggers before any rule-file write.
3. Create `history/skill_YYYYMMDD.md` immediately when a trigger is true; otherwise record `daily-history-trigger: no-op` in the final execution report.
4. Revise related rule documents.
5. Record root cause, changes, and prevention rules in history artifacts.
6. Run the mandatory cross-review phases defined in `## Cross-Review Requirement Rule` and record the result in the final execution report.
7. Cross-check modified rule files and generated history files before completion reporting.

# Definition of Done

## Verification
- The checks in `## Daily History Trigger Rules` are completed before rule-document edits.
- The required outputs in `## Outputs` are produced according to trigger results.
- The content requirements in `## Required Daily History Content` are satisfied when daily history is created.
- The writing constraints in `## Recording Rules` are satisfied.
- The language constraints in `## Skill-Scoped History Language Rule` are satisfied.
- The execution and reporting behavior in `## Cross-Review Requirement Rule` is satisfied, including mandatory phase coverage.
