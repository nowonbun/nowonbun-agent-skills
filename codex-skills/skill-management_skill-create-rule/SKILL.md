---
name: skill-create-rule
description: Authors who create or revise SKILL.md files must follow these structural and meaning-preservation rules.
---

# Skill Create Rule

# Must

## Scope
- You must apply this document when creating or revising `SKILL.md` files distributed as skills, or their source skill documents.
- The purpose of this document is to keep skill documents as executable harnesses, not explanatory prose.

## Out of Scope
- You must not apply all skill-specific rules in this document to history documents under `history/`.
- You must not apply the skill-specific format rules in this document as-is to README, AGENTS, or general memo documents.
- You must not define governance tiers, risk triggers, or approval policies in this document.

## Structure
- Always place YAML frontmatter at the top of the file.
- Frontmatter must include only `name` and `description`.
- Under frontmatter, place exactly one blank line and then a titled document H1.
- Required section H1 headers (`# Must`, `# Must NOT`, `# Definition of Done`, and optional `# Flow`) must appear after the document H1.
- The body must include `# Must`, `# Must NOT`, and `# Definition of Done`.
- Include `# Flow` only when procedural order affects the outcome.
- If there are rules not covered by the required H1 sections above, add separate H1 sections. Must not replace required H1 sections.
- If an H1 contains two or more independent topics, use H2.
- If an H1 contains only one independent topic, you must not add H2.
- Use numbered lists only for procedures that require sequence.
- Use `-` lists only for parallel rules, conditions, or checklist items.
- You must write PlantUML (`puml`) when any of the following is true:
  - There are parallel steps.
  - There are retry, rollback, or re-entry paths after failure.
  - There are two or more approval or decision actors.
- If none of the conditions above apply, use text or lists.
- If any exception condition, detailed rule, or interpretation standard that should be in the diagram is not represented as a label, note, or guard condition, you must add text explanation for:
  - exception conditions
  - detailed rules
  - interpretation standards
- You must add output examples when any of the following is true:
  - Two or more interpretations occur under the same rule.
  - Input format is not explicitly defined.
  - Output format is not explicitly defined.
- If none of the conditions above apply, you must not add output examples.
- Under `# Definition of Done`, include at least `## Verification`.
- Under `# Definition of Done`, include `## Monitoring` when any of the following is true:
  - Automation, batch jobs, or agent loops exist.
  - Missing, delayed, or failed execution results must be monitored in operations.
  - Logs, metrics, or alerts are part of operational standards.
- If the conditions above are not met, you must not write `## Monitoring`, and you must not add placeholder-only content such as `N/A`.

## Frontmatter
- The format must exactly follow the structure below.

```yaml
---
name: <skill-name>
description: <One sentence describing what it does and when to apply it>
---
```

- `name` allows only lowercase letters, numbers, and hyphens.
- `name` must be 64 characters or fewer.
- Connect compound words with hyphens.
- Write `description` as one English sentence.
- `description` must include target, situation, and action.
- You must not use ambiguous terms in `description` such as `if needed`, `appropriately`, `depending on situation`, or `if possible`.

## Rule Writing
- Write rules as executable rules, not explanatory prose.
- Each rule must instruct only one action.
- The force of each rule must be explicit in the sentence itself.
  - Mandatory: `must`, `always`
  - Conditional mandatory: `must when <condition>`
  - Prohibition: `prohibited`, `must not use`
- For rules requiring conditions, write the condition first.
- If exceptions exist, write them in the same item.
- You must not omit rules that require failure handling or fallback paths.
- Separate behavior rules from reporting formats.
- Each item must contain only one action.
- If a rule already defined in another section needs to be restated as a checklist or compliance criterion in the current section, you must not duplicate the original sentence; replace it with a reference sentence that indicates which section’s rule is being verified or followed.
- You must keep explicit rule text instead of reference-only wording when either of the following is true:
  - Pass/fail cannot be evaluated from the reference alone.
  - Required actor, condition, or failure handling cannot be identified from the reference alone.
- When referencing another skill or governed document within rule text, you must use the frontmatter `name` value, not a file path or filename with extension.

## Language and Companion Documentation
- When creating or revising skill documents, you must write all rule content in English.
- You must create a Korean explanation document at `doc/<relative-skill-path>/<skill-name>-readme.md`.
- `<relative-skill-path>` must match the skill file path relative to the repository root.
- The Korean explanation document must describe purpose, key rules, and usage cautions without changing the original rule meaning.
- When writing or revising history files under `history/<relative-skill-path>/<skill-name>/`, you must inherit the language used by the latest existing history file in the same folder.
- If no history file exists in the target history folder, you must use Korean as the default history language.

## History Recording
- When revising a skill document, you must leave a modification history record under `history/<relative-skill-path>/<skill-name>/`.
- `<relative-skill-path>` must match the skill file path relative to the repository root.

## Completion Gate
- When creating or revising a skill document, you must complete these artifacts in the same change set: skill rule file, Korean readme, and history record.
- Before final completion reporting, you must verify existence of all three artifacts using file-path evidence.
- If at least one required artifact is missing, you must stop completion reporting and create the missing artifact first.

## Source of Truth
- Each self-declaration must state what this document governs and explicitly what it does not govern.
- Each external reference must state: the document, the reusable decision boundary it resolves, and why that judgment belongs there and not in this document.
- Must not write an entry that names a document and topic without stating a scope boundary or decision context.
- Must not justify a Source of Truth entry with one-off examples, temporary exceptions, revision-local intent, or workflow-local context.
- The section must function as a conflict-resolution guide: a reader with an ambiguous judgment must be able to identify which document to consult and why.
- This document governs skill-document writing format, section structure, rule-strength vocabulary, and meaning-preservation constraints; it does not govern governance tiers, risk triggers, or strict-vs-baseline control decisions.
- `../skill-management_skill-governance-rule/SKILL.md` is the single source of truth for governance tier assignment and strict-trigger conditions; consult it when deciding approval requirements or risk classification, not for format or structure questions.
- `../skill-management_skill-modify-history/SKILL.md` is the single source of truth for history-record creation obligations and day-based criteria; consult it when deciding whether a revision requires a new history file, not for what the skill document itself must contain.
- `../tool-usage-management_claude-cross-review-protocol/SKILL.md` is the single source of truth for cross-review invocation format and output schema; consult it when a review output must conform to a defined log structure, not for how to write skill rules.
- `global_instructions` is the single source of truth for global response principles and user profile; it takes priority over all other documents when conflicts arise.

# Must NOT

## Ambiguity
- Must not use `appropriately`, `if needed`, `if possible`, `depending on situation`, or `flexibly` without decision criteria.
- Must not include common-sense sentences, rhetorical phrasing, or redundant explanations.

## Duplication
- Must not copy rules from other documents without identifying the original source.
- Must not repeat the same rule across multiple sections.
- Must not place one rule redundantly in both mandatory and prohibited sections.

## Weak Compression
- Must not weaken mandatory / conditional mandatory / prohibition levels for compression.
- Must not delete application conditions, exceptions, order dependencies, or failure handling for compression.
- Must not change `must` to `do`, or `prohibited` to `discouraged`.

## Wrong Structure
- Must not leave only long-form explanations directly under H1 while omitting executable rules.
- Must not use numbered lists for rules without sequence.
- Must not write sequential procedures as `-` lists.

# Flow

## Authoring
1. Define Scope and Out of Scope first.
2. Specify Source of Truth.
3. Write mandatory rules in Must.
4. Write prohibited rules in Must NOT.
5. If procedural order affects the result, write the procedure in Flow.
6. Write completion criteria in Definition of Done.
7. At the end, review whether action outcomes are identical before and after compression.

## Compression Review
1. Before compressing rules, split core action units first.
2. Verify who performs each rule, when, what, and with what force level.
3. Mark rules that require exceptions, order dependencies, or failure handling separately.
4. Verify that completion criteria remain unchanged after compression.

# Definition of Done

## Verification
- Follows `## Frontmatter` rules and contains only `name` and `description`.
- Follows `## Structure` rules, and body H1 composition, H1 order, and list usage standards are verifiable.
- `## Verification` exists under `# Definition of Done`.
- If `## Monitoring` exists, it satisfies Monitoring conditions in `## Structure`.
- If `## Monitoring` does not exist, it does not conflict with non-applicability conditions in `## Structure`.
- If PlantUML is used, it follows application conditions and text-support explanation criteria in `## Structure`.
- If PlantUML is not used, it does not conflict with non-applicability conditions in `## Structure`.
- Each Source of Truth entry states scope boundary and, for external references, the reusable decision boundary, decision context, and reason for delegation.
- Source of Truth entries do not rely on one-off examples, temporary exceptions, revision-local intent, or workflow-local context.
- Rule strength, condition-first writing, exception handling, reference-substitution, and skill-reference naming rules follow `Rule Writing` criteria.
- Rules in `Language and Companion Documentation` are satisfied, including Korean rule authoring and Korean readme placement.
- History file language follows the latest history file in the same folder, or defaults to Korean when no prior history file exists.
- Rules in `History Recording` are satisfied, including the history path pattern and per-skill path placement.
- Rules in `Completion Gate` are satisfied, including three-artifact completion and pre-report existence verification.
- There are no expressions violating ambiguity/duplication/structure prohibition rules in `Must NOT`.
