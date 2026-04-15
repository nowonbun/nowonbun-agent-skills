---
name: vocabulary-rule
description: Agents and authors must use this global vocabulary baseline to interpret term meanings and rule-strength expressions consistently across governed documents.
---

# Vocabulary Rule

# Must

## Scope
- You must apply this document to term and strength interpretation in `global_instructions`, `CLAUDE`, `AGENTS`, and `SKILL.md`-family documents.
- `SKILL.md`-family means the root `SKILL.md` file and all companion files explicitly referenced from that `SKILL.md`.
- You must apply this document before task-intent interpretation, workflow trigger interpretation, and write-action decisions.
- All paths in this document are project-root-relative paths unless explicitly marked as absolute paths.

## Out of Scope
- You must not define implementation details, architecture design details, or code-style rules directly in this document.
- You must not define rationale-storage operations (storage location, retention period, or ticket linkage) in this document.

## Source of Truth
- This document governs vocabulary interpretation, rule-strength interpretation, registry category boundaries, and term-normalization behavior in `./SKILL.md`; it does not govern constitution-authoring boundaries, skill-document format design, or history-record creation timing.
- `../skill-management_constitution-rule/SKILL.md` is the single source of truth for constitution-authoring boundaries; consult it when deciding how constitution layers, priority, and prohibited behaviors must be authored, not for vocabulary meaning or rule-strength interpretation.
- `../skill-management_skill-create-rule/SKILL.md` is the single source of truth for skill-document format constraints; consult it when deciding how a skill document must be structured or written, not for vocabulary meaning or registry category decisions.
- `../skill-management_skill-modify-history/SKILL.md` is the single source of truth for rationale/history recording operations; consult it when deciding whether and how vocabulary-rule revisions must be recorded, not for vocabulary registry meaning or rule-strength interpretation.

## Registry Control
- You must maintain the active registry at `codex-skills/vocabulary-management/vocabulary-registry.md`.
- The registry must contain at least one executable term entry at all times.
- You must use only these categories: `priority`, `time`, `scope`, `state`, `risk`, `action`, `report-status`.
- The category set above must be treated as sufficient because it covers decision axis, temporal axis, boundary axis, lifecycle axis, risk axis, operation axis, and reporting axis.
- For each term entry, you must define `term`, `category`, `canonical meaning`, `decision rule`, `allowed values`, and `prohibited interpretations`.

## Strength Definitions
- `must` and `always` expressions must be interpreted as mandatory obligations.
- `should` and `recommended` expressions must be interpreted as recommended actions that require recorded rationale when not followed.
- `should not` expressions must be interpreted as discouraged actions that require recorded rationale when performed.
- `must not` and `do not use` expressions must be interpreted as unconditional prohibitions.
- Obligation, recommendation, and prohibition must not be mixed in one rule item.

## Term Definitions
- `rule` means one sentence unit that instructs an actor behavior.
- `verification` means a procedure that checks whether rules are followed.
- `done` means a terminal state where completion checks are satisfied.
- `exception` means a condition that narrowly overrides a default rule.
- `single source of truth` means the final authority document for one meaning.

## Global Execution Behavior
- Before any write action, you must normalize ambiguous terms to this document definitions and the active registry.
- If an unresolved term affects irreversible actions or shared state, you must stop and request user confirmation.
- If unresolved terms remain for reversible actions, you must mark the assumption as `unverified` before proceeding.
- If reversibility cannot be determined, you must treat the action as irreversible and request user confirmation.
- If relative dates are used, you must convert them to absolute dates before final decision and reporting.

## Priority Resolution
- When interpretation conflicts occur, you must apply the priority model defined in `../skill-management_constitution-rule/SKILL.md` `# Must > ## Priority Model`.
- You must treat the priority order as `global_instructions` > `AGENTS` unless a higher-layer delegation explicitly overrides it.

## History Path
- The configured history path for this skill is `history/codex-skills/vocabulary-management_vocabulary-rule/vocabulary-rule/`.
- When registry meaning or rule interpretation changes, you must record the revision in the configured history path.

# Must NOT

## Ambiguity
- You must not use `appropriately`, `when needed`, `depending on situation`, `if possible`, or `important` without explicit decision criteria.
- You must not redefine the same term with different meanings across documents.

## Weakening
- You must not weaken mandatory language into generic descriptive prose.
- You must not downgrade prohibition language into recommendation language.

## Duplication
- You must not copy the same term definition into multiple documents.
- If reuse is required, you must reference this document or the active registry instead of duplicating definition text.

# Flow

## Authoring
1. Extract key terms and strength expressions from target documents.
2. Check conflicts against this document definitions and the active registry.
3. If conflict exists, revise target documents to align with this document and registry.
4. If a new term is required, add definition, example, and prohibited misunderstanding together.

## Review
1. Verify obligation/recommendation/prohibition expressions are not mixed.
2. Verify ambiguous terms are not used without criteria.
3. Verify single-source references are explicitly present.
4. Verify unresolved-term handling includes unknown-reversibility fallback.
5. Verify registry entries are complete and category values are inside the closed list.
6. Present execution result and normalization log to the user as success/failure/no-op.

# Definition of Done

## Verification
- Strength expressions are distinguishable per sentence as obligation/recommendation/prohibition.
- Core term definitions exist without duplication.
- No forbidden ambiguous-term usage is present.
- Single-source reference documents are explicitly identified.
- Active registry exists and contains at least one executable term entry.
- If term meaning was revised, a history record exists in `history/codex-skills/vocabulary-management_vocabulary-rule/vocabulary-rule/`.

## Monitoring
- The terminology-conflict checklist must be maintained at `codex-skills/vocabulary-management/vocabulary-terminology-conflict-checklist.md` by the designated document owner.
- When a new governed document is added, you must include this document in the terminology-conflict checklist.
- At least once per quarter, the designated document owner (human reviewer or automation maintainer) must sample governed documents and verify strength-expression consistency.
