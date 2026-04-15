---
name: ai-agent
description: Engineers designing AI agents must use this skill to define operating problems, decision boundaries, tool contracts, and verification plans.
---

# AI Agent Skill

# Must

## Scope
- You must apply this document when designing or reviewing an AI agent that combines LLM reasoning, tools, MCP servers, or workflow orchestration.
- You must define the agent as an operating system for a task, not as a list of isolated features.

## Source of Truth
- This document governs AI-agent problem framing, decision-boundary definition, tool-contract definition, and verification-plan structure in `./SKILL.md`; it does not govern coding-change review flow, cross-review runtime execution, or repository-wide skill format rules.
- `../action-management_coding-assistant/SKILL.md` is the single source of truth for implementation-time collaboration, review sequencing, and change-reporting decisions; consult it when an AI-agent design task moves into concrete code-change execution, not for agent-design structure decisions.

## Problem Definition Rules
- You must define the operating problem before proposing architecture.
- You must identify target users, failure cost, and success criteria before tool selection.
- You must separate business goal, runtime constraint, and non-goal into different bullets.

## Decision Boundary Rules
- You must define which decisions the agent can make autonomously.
- You must define which actions require user approval or operator approval.
- You must define blocked actions that the agent must never execute.

## Pipeline Design Rules
- You must document the pipeline in this order:
  1. input collection
  2. intent interpretation
  3. context retrieval
  4. plan generation
  5. tool execution
  6. result verification
  7. response generation
  8. logging and observability
- You must define entry condition, output contract, and failure handling for each stage.

## LLM and Tool Contract Rules
- You must define each LLM call with explicit input, expected output, and rejection condition.
- You must place LLM reasoning only on stages that require ambiguity resolution or synthesis.
- You must define every MCP or external-tool integration with schema, timeout, retry policy, and failure-isolation behavior.

## State and Memory Rules
- You must separate session state, cache, and long-term storage by purpose.
- You must define what data may be persisted and what data must remain ephemeral.
- You must define how stale state is detected or invalidated.

## Observability and Verification Rules
- You must define traceable identifiers for requests and tool-execution steps.
- You must define logs or metrics that expose tool usage, model calls, validation failures, and operator interventions.
- You must provide validation scenarios for success path, failure path, approval path, and rollback path.

# Must NOT

## Prohibited Design Behavior
- You must not start with model choice before problem definition is fixed.
- You must not merge LLM responsibility, application control, and audit responsibility into one undefined block.
- You must not leave approval boundaries implicit.
- You must not describe prompt text as the only control mechanism for safety or policy enforcement.
- You must not omit failure handling for a stage that can call a tool or modify state.

# Flow

## Design Flow
1. Define the operating problem, target users, and success criteria.
2. Define constraints, non-goals, and failure cost.
3. Define autonomous, approval-required, and blocked decisions.
4. Design the pipeline stages and per-stage contracts.
5. Define LLM-call placement and tool/MCP contracts.
6. Define state boundaries, observability, and verification scenarios.
7. Hand off implementation-specific work to `../action-management_coding-assistant/SKILL.md` when coding changes are required.

# Definition of Done

## Verification
- Problem definition exists before architecture description.
- Decision boundaries are separated into autonomous, approval-required, and blocked actions.
- Pipeline stages are documented in the required order with contracts and failure handling.
- LLM and tool integrations have explicit contracts.
- State separation and observability rules are documented.
- Validation scenarios cover success, failure, approval, and rollback paths.
