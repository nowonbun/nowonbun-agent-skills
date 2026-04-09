---
name: constitution-rule
description: Authors who create or revise global_instructions.md as the primary constitution target and align CLAUDE.md and AGENTS.md must apply this rule to define priority, prohibition, and operation boundaries.
---

# Constitution Rule

# Must

## Scope
- You must apply this document when creating or revising `global_instructions.md`, `CLAUDE.md`, or `AGENTS.md`.
- You must treat this document as a content-governance rule for constitution documents, not as a markdown-format rule.

## Target Documents
- You must define system-level identity, global principles, response principles, and non-negotiable safety rules in `global_instructions.md`.
- You must define model-specific execution protocol, collaboration boundaries, and review workflow in `CLAUDE.md`.
- You must define repository or workspace execution triggers, folder roles, and task-operational rules in `AGENTS.md`.

## Constitution Layers
- You must define exactly three constitution layers: global, model, and workspace.
- You must map `global_instructions.md` to the global layer.
- You must map `CLAUDE.md` to the model layer.
- You must map `AGENTS.md` to the workspace layer.

## Global Principles
- You must write global principles as deterministic rules that can be validated from execution logs or file outputs.
- You must define an explicit language rule for assistant responses.
- You must define an explicit evidence rule that prohibits presenting assumptions as facts.
- You must define an explicit safety rule for restricted paths and data-protection boundaries.

## Priority Model
- You must define one closed priority order across constitution documents.
- You must set priority as `global_instructions.md` > `CLAUDE.md` > `AGENTS.md` when no stricter repository rule is declared.
- You must declare one conflict-resolution rule for equal-priority collisions.
- You must declare one fallback rule for missing instructions.

## Prohibited Rules Definition
- You must define a closed list of prohibited behaviors for each constitution layer.
- You must include at least one prohibition for flattery, one for unsupported claims, and one for instruction override without authority.
- You must define enforcement behavior for prohibition violations.

## AGENTS Folder Role
- You must define the role of each governed folder before writing folder-specific rules.
- You must require path-specific trigger rules when an action is intended to run only in a specific folder.
- You must define one ownership boundary per folder role.

## AGENTS Core Rules
- You must define exact trigger phrases for each automated workflow.
- You must define execution order when a workflow has two or more steps.
- You must define stop conditions and failure-report format for each workflow.
- You must define re-run policy when duplicate execution risk exists.

## Execution Stop Conditions
- You must stop execution when a required input is missing.
- You must stop execution when a required input is ambiguous.
- You must stop execution when two or more active rules conflict without a defined resolver.
- You must stop execution when the target file path cannot be resolved to one canonical location.
- You must stop execution when a write action would modify content outside the declared instruction scope.
- You must request explicit user confirmation before resuming from a stop condition.

## Workflow Report Format
- You must format every workflow failure report with `finding`, `evidence`, and `next action`.
- You must format every stop-condition confirmation request with `blocked by`, `requested decision`, and `impact`.
- You must reject a workflow report that omits any required report field.

## Source Reference Availability
- You must verify that each source-of-truth file is accessible before using it as a normative reference.
- You must stop the current step when a required source-of-truth file is missing.
- You must request user confirmation before replacing a missing source-of-truth file with fallback judgment.

## Re-run and Overwrite Policy
- You must read the current target file state before each write attempt.
- You must treat re-running the same instruction on an already compliant file as `no-op`.
- You must report `no-op` when no file change is required.
- You must run revision flow instead of creation flow when `global_instructions.md` already exists.
- You must not overwrite user-added content outside the declared instruction scope.
- You must request explicit user approval when re-run changes would touch out-of-scope content.

## Skill and MCP Operation Rules
- You must define skill-selection criteria before defining skill execution steps.
- You must require source verification before invoking MCP tools.
- You must define parameter-validation rules for each MCP server before write operations.
- You must define post-action reporting format for each MCP write action.

## Source of Truth
- This document is the single source of truth for constitution-document content boundaries, priority rules, and operational rule coverage.
- `skill-create-rule.md` is the single source of truth for structure and writing-format constraints of skill documents.
- `skill-governance-rule.md` is the single source of truth for governance-tier and strict-trigger controls.
- `skill-modify-history.md` is the single source of truth for history-record policy.

# Must NOT

## Ambiguity
- You must not use open-ended terms without decision criteria in constitution rules.
- You must not define priority words such as `important` or `higher` without numeric or ordered ranking.

## Scope Mixing
- You must not place workspace-trigger details in `global_instructions.md`.
- You must not place global identity or universal behavior principles only in `AGENTS.md`.
- You must not duplicate the same rule text across `global_instructions.md`, `CLAUDE.md`, and `AGENTS.md`.

## Priority Omission
- You must not publish constitution documents without an explicit conflict-resolution order.
- You must not allow lower-priority documents to override higher-priority documents without an explicit authority rule.

## Operational Gaps
- You must not define MCP usage rules without tool-parameter validation requirements.
- You must not define automated workflows without stop conditions.
- You must not define failure handling without re-run conditions.

# Flow

## Constitution Authoring
1. Verify availability of required source-of-truth files before rule authoring.
2. Classify each target rule into global, model, or workspace layer.
3. Check whether `global_instructions.md` exists before selecting create or revision flow.
4. Run global create flow when `global_instructions.md` is missing.
5. Run global revision flow when `global_instructions.md` already exists.
6. Assign each classified rule to `global_instructions.md`, `CLAUDE.md`, or `AGENTS.md`.
7. Define priority order, conflict resolution, and fallback behavior.
8. Define prohibited rules and enforcement behavior per layer.
9. Define AGENTS folder roles and workflow trigger rules.
10. Define skill-selection and MCP operation rules.
11. Verify cross-document consistency and remove duplicated rule text.

## Global Instructions Create Flow
1. Create `global_instructions.md` with constitution layer, principles, priority model, and prohibition set.
2. Validate that required global sections are present before proceeding to dependent documents.
3. Stop and report failure with required workflow report fields when required global sections are missing.

## Global Instructions Revision Flow
1. Diff the current `global_instructions.md` content against requested changes.
2. Apply targeted edits only to requested or policy-required sections.
3. Preserve unaffected sections during revision.
4. Stop and request user approval when revision scope expands beyond the request.

## Constitution Review
1. Verify every rule is placed in the correct layer.
2. Verify priority and conflict handling are deterministic.
3. Verify each workflow has trigger, order, stop, failure, and re-run coverage.
4. Verify each MCP rule includes source check, parameter check, and report requirement.
5. Verify stop-condition confirmation requests follow the required confirmation-request format.

# Definition of Done

## Verification
- The document contains YAML frontmatter with only `name` and `description`.
- The document contains required H1 sections: `# Must`, `# Must NOT`, `# Flow`, and `# Definition of Done`.
- The document contains `## Verification` under `# Definition of Done`.
- Each rule sentence uses explicit force terms (`must`, `must not`, or equivalent prohibition language).
- Priority order, conflict resolution, and fallback behavior are explicitly defined.
- Coverage for `global_instructions.md`, `CLAUDE.md`, and `AGENTS.md` is explicitly defined.
- AGENTS folder-role, trigger, order, failure, and re-run requirements are explicitly defined.
- Skill and MCP operation rules include source checks, parameter validation, and reporting obligations.
- Prohibited behaviors and enforcement behavior are explicitly defined.
- Create and revision flows for `global_instructions.md` are explicitly separated.
- Execution stop conditions are explicitly defined.
- Re-run and overwrite policy is explicitly defined.
- Workflow failure reports and stop-condition confirmation requests follow defined report formats.
- Source-of-truth availability checks are explicitly defined.
- No section violates ambiguity, duplication, or scope-mixing prohibitions.
