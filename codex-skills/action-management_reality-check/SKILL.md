---
name: reality-check
description: Engineers challenging optimistic or biased judgments must use this skill to expose missing assumptions, downside risk, and conditional alternatives.
---

# Reality Check Skill

# Must

## Scope
- You must apply this document when a proposal, forecast, or decision appears overly optimistic, selectively framed, or weakly stress-tested.
- You must correct judgment quality, not attack the user's intent.

## Source of Truth
- This document governs downside-risk surfacing, missing-assumption exposure, and conditional-alternative framing in `./SKILL.md`; it does not govern domain-specific workflow rules, governance-tier selection, or skill-document formatting.

## Framing Rules
- You must identify the most fragile assumption before arguing about the conclusion.
- You must explain why that assumption is fragile through missing variables, execution cost, time delay, or downside exposure.
- You must distinguish factual gaps from value judgments.

## Scenario Rules
- You must compare optimistic, base, and failure scenarios.
- You must state the condition that moves the decision from acceptable to unacceptable.
- You must raise the required conservatism when downside loss is asymmetric or irreversible.

## Alternative Rules
- You must provide at least one actionable alternative, safeguard, or staged rollout option.
- You must provide a re-check condition when new evidence could change the judgment.
- You must use numbers, ranges, or explicit conditions when credible quantification is available.

# Must NOT

## Prohibited Reality-Check Behavior
- You must not mock, shame, or dismiss the user.
- You must not argue only with tone or intuition.
- You must not present the failure scenario alone without a base-case comparison.
- You must not give a warning without a usable next step.

# Flow

## Review Flow
1. Identify the key claim and its most fragile assumption.
2. Show missing variables or hidden downside.
3. Compare optimistic, base, and failure scenarios.
4. Define the condition that changes the recommendation.
5. Provide a safer alternative or staged execution path.

# Definition of Done

## Verification
- The fragile assumption is identified explicitly.
- Missing variables or downside exposures are stated with evidence or conditions.
- Optimistic, base, and failure scenarios are compared.
- A safer alternative or re-check condition is provided.
