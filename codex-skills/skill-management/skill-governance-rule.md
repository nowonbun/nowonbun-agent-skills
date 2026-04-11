---
name: skill-governance-rule
description: Authors who design or revise skill governance policies must apply these deterministic trigger, control, and verification rules.
---

# Skill Governance Rule

# Must

## Scope
- You must apply this document when defining governance tiers, risk triggers, approval policies, or execution-control requirements for skills.
- This document governs risk-based control selection, not markdown formatting structure.

## Governance Model
- You must use exactly two governance tiers: `baseline` and `strict`.
- You must select `strict` when at least one strict trigger is true.
- If no strict trigger is true, you must select `baseline`.

## Strict Triggers
- Strict triggers are exactly the following:
  - The skill governs destructive operations (`delete`, `reset`, `force`, irreversible overwrite).
  - The skill governs external write actions to these service systems: Slack, Jira, Confluence, Google Drive, GitHub.
  - The skill governs authentication, authorization, permission, or credential handling.
  - The skill changes deployment target, runtime configuration, or externally visible API behavior.

## Baseline Controls
- Baseline controls must require only the minimum controls below:
  - one clear execution path
  - one clear completion check
  - one clear failure report path
- Under baseline, you must not require any of the following:
  - mandatory multi-stage review cycles
  - mandatory external approval gates
  - mandatory cross-system posting or notification steps

## Strict Controls
- Under strict governance, you must define explicit actor, approval condition, and rollback path for each active strict trigger.
- Under strict governance, you must define failure handling steps with retry limits and stop conditions.
- Under strict governance, you must define at least one verification step tied to each active strict trigger.

## Rule Priority
- When governance rules conflict with format rules, governance rules control risk-handling behavior and format rules control document structure.
- `## History Recording` is mandatory in skill authoring regardless of governance tier.

## Source of Truth
- This document is the single source of truth for governance tiers, strict triggers, and baseline-vs-strict control boundaries.
- `skill-create-rule.md` is the single source of truth for skill document format and structure.

# Must NOT

## Ambiguity
- You must not use open-ended governance terms without a closed list or explicit decision criteria.
- You must not use undefined labels such as `high risk`, `critical`, or `heavyweight` without deterministic criteria.

## Scope Drift
- You must not define markdown formatting requirements in this document.
- You must not duplicate format/section layout rules that belong to `skill-create-rule.md`.

## Over-Governance
- You must not apply strict-only controls when no strict trigger is active.
- You must not add strict triggers beyond the closed set in `## Strict Triggers`.

# Flow

## Governance Authoring
1. Confirm whether the target rule is governance-related.
2. Select governance tier by evaluating strict triggers.
3. Write controls for the selected tier.
4. Define verification for active controls.
5. Check consistency with `skill-create-rule.md`.

## Governance Review
1. Verify strict-trigger evaluation is reproducible.
2. Verify no strict-only control leaks into baseline.
3. Verify each active strict trigger has actor/approval/rollback/failure/verification coverage.

# Definition of Done

## Verification
- Governance tier selection rules are deterministic and reproducible.
- Strict trigger set is closed and unchanged.
- Baseline and strict controls are explicitly separated.
- Ambiguous governance labels are absent or explicitly defined.
- Source-of-truth boundaries with `skill-create-rule.md` are explicit.
