---
name: automation
description: Engineers designing or improving automation must use this skill to evaluate operating value, control execution boundaries, and define recovery procedures.
---

# Automation Skill

# Must

## Scope
- You must apply this document when designing, reviewing, or extending automation for scripts, CI/CD, scheduled jobs, or local and cloud operations.
- You must evaluate automation as an operating system with control and recovery, not as a one-off script.

## Source of Truth
- This document governs automation value framing, execution-boundary definition, and recovery-structure design in `./SKILL.md`; it does not govern governance-tier selection, document-format rules, or MCP-specific validation procedures.

## Value and Suitability Rules
- You must evaluate whether automation reduces operating cost, error rate, or response time before implementation.
- You must reduce scope when exception frequency or manual judgment cost makes full automation unsafe.
- You must document why the task should be fully automated, partially automated, or kept manual.

## Workflow Design Rules
- You must separate the workflow into trigger, input collection, pre-validation, main execution, post-validation, and reporting.
- You must define the execution owner and execution condition for each workflow.
- You must document dependencies, external systems, and required credentials explicitly.

## Control Rules
- You must classify execution into automatic, scheduled, approval-required, or operator-only modes.
- You must apply stricter control to deletion, deployment, payment, permission change, and large-scale update actions.
- You must make manual intervention points explicit.

## Failure and Recovery Rules
- You must define retry conditions separately from immediate-stop conditions.
- You must define how duplicate runs, partial success, timeout, and upstream-service failure are detected.
- You must define rollback or manual recovery steps for workflows that can change external state.

## Security and Operability Rules
- You must store secrets through environment variables, secret managers, or equivalent controlled storage.
- You must define logs, alerts, and audit trails needed for operators.
- You must define where configuration lives and how operators can override or disable the automation safely.

# Must NOT

## Prohibited Automation Behavior
- You must not automate a workflow only because scripting is technically possible.
- You must not hide operator-only steps or approval points.
- You must not store secrets in source-controlled plaintext files.
- You must not omit post-validation when the workflow changes shared state or production systems.
- You must not expand automation scope when recovery capability is undefined.

# Flow

## Design Flow
1. Evaluate operating value and automation suitability.
2. Decide full automation, partial automation, or manual handling.
3. Define workflow stages, owners, dependencies, and control mode.
4. Define validation, failure detection, retry, and recovery behavior.
5. Define security controls, logs, alerts, and operator override method.
6. Verify that automation scope does not exceed recovery capability.

# Definition of Done

## Verification
- Automation value and scope decision are documented.
- Workflow stages, owners, and dependencies are explicit.
- Control mode and approval points are documented.
- Failure detection, retry, stop, and recovery rules are explicit.
- Secret handling, logging, and operator controls are documented.
