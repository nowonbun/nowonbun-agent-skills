---
name: engineer
description: Engineers solving software problems must use this skill to define the problem, rank root-cause hypotheses, compare fixes, and verify rollback safety.
---

# Engineer Skill

# Must

## Scope
- You must apply this document when analyzing or solving software design, implementation, debugging, or operational problems.
- You must treat the task as problem solving with verification, not as immediate patch writing.

## Source of Truth
- This document governs engineering problem definition, hypothesis ranking, fix-option comparison, and rollback-safety reasoning in `./SKILL.md`; it does not govern domain-specific analysis structure, governance-tier assignment, or cross-review log formatting.

## Problem Definition Rules
- You must define the problem with symptom, reproduction condition, expected behavior, actual behavior, and impact scope.
- You must state when the problem started or mark the time information as unverified.
- You must identify whether the task requires immediate mitigation, root-cause removal, or both.

## Hypothesis Rules
- You must list root-cause hypotheses in priority order.
- You must define a falsification or confirmation method for each hypothesis.
- You must test the fastest eliminable hypotheses before high-cost hypotheses when evidence quality is similar.

## Solution Comparison Rules
- You must separate temporary mitigation, permanent fix, and recurrence-prevention actions.
- You must compare candidate fixes by implementation cost, verification depth, rollback ease, and side-effect risk.
- You must state why the recommended fix is safer than more invasive alternatives.

## Change and Verification Rules
- You must define how the change will be validated through reproduction, tests, logs, metrics, or operator checks.
- You must define rollback conditions for changes that can worsen service behavior.
- You must mark assumptions as unverified when direct evidence is unavailable.

# Must NOT

## Prohibited Engineering Behavior
- You must not jump from symptom to fix without a fixed problem statement.
- You must not present one hypothesis as fact before evidence is collected.
- You must not recommend large-scale refactoring when a smaller verified fix can solve the problem.
- You must not declare completion without a verification method or rollback path.

# Flow

## Analysis Flow
1. Fix the problem statement and impact scope.
2. Build prioritized root-cause hypotheses with test methods.
3. Run the lowest-cost high-value checks first.
4. Compare mitigation, permanent fix, and recurrence-prevention options.
5. Select the recommended fix with verification and rollback plan.
6. Report verified facts, unverified assumptions, and remaining risks.

# Definition of Done

## Verification
- Problem statement includes symptom, reproduction condition, expected behavior, actual behavior, and impact scope.
- Root-cause hypotheses are prioritized and testable.
- Candidate fixes are compared by cost, safety, and rollback ease.
- Verification and rollback methods are explicit.
- Unverified items are labeled as unverified.
