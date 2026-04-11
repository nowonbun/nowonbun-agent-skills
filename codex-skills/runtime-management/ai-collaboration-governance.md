---
name: ai-collaboration-governance
description: Agents coordinating Codex and Claude must enforce deterministic timeout, fallback, and prompt-size controls during Claude CLI collaboration.
---

# AI Collaboration Governance

# Must

## Scope
- You must apply this document when running Claude CLI collaboration for implementation or review workflows.
- You must apply this document to runtime controls for timeout prevention, fallback handling, and prompt-size control.

## Source of Truth
- This document is the single source of truth for Claude collaboration runtime controls.
- ../tool-usage-management/claude-cross-review-protocol.md is the single source of truth for cross-review log fields and review-output format.
- `D:/work/nowonbun-harness/CLAUDE.md` is the single source of truth for review policy profile content.

## Path Resolution Rules
- You must resolve the review policy path as `D:/work/nowonbun-harness/CLAUDE.md`.
- When `D:/work/nowonbun-harness/CLAUDE.md` is unreadable or missing, you must stop execution and report `cross-review: blocked (reason: review policy path unavailable)`.

## Request Classification Rules
- You must classify a request as heavy when at least one condition is true:
  - prompt text exceeds 2000 characters
  - request items exceed 5
  - target files exceed 3
  - MCP reference is included
- You must classify a request as light when none of the heavy conditions are true.

## Timeout and Healthcheck Rules
- You must enforce a maximum wait time of 5 minutes for each claude -p invocation.
- Before every heavy request, you must run claude --version and `claude -p "Return exactly: OK"`.
- When either healthcheck does not complete within 5 minutes, you must stop heavy requests and start timeout fallback flow.

## CLAUDE.md Profile Injection Rules
- You must extract the review profile block between <!-- REVIEW_PROFILE:START --> and <!-- REVIEW_PROFILE:END --> from `D:/work/nowonbun-harness/CLAUDE.md` when the markers exist.
- When the review profile markers do not exist, you must derive the review profile from the current `CLAUDE.md` sections that define review position, core review objectives, primary review concerns, review output expectations, review decision guidance, encoding and document review rules, and prohibited review behavior.
- You must inject only the extracted or derived review profile into claude -p requests.
- When profile extraction and profile derivation both fail or produce empty content, you must stop execution and report missing profile input.
- When extracted profile length exceeds 1200 characters, you must compress by keeping this priority order:
  1. Prohibited
  2. Severity
  3. Focus axes
  4. Output mode
- During compression, you must not delete `Prohibited`, `Severity`, or Role sections.

## Prompt Size Control Rules
- You must keep each claude -p request within these limits:
  - prompt text: 2000 characters or fewer
  - request items: 5 or fewer
  - target files: 3 or fewer
- When a request exceeds limits, you must split it into investigation, implementation, and review stages.
- You must limit MCP types referenced in one request to 2 or fewer.

## Split-Flow Handoff Rules
- Plan-review stage output must be passed as implementation stage input using this structure: `findings`, `candidate files`, and `constraints`.
- Source-review stage input must include `changed files`, `diff scope summary`, and `expected invariants`.
- Result-review stage input must include `changed files`, `change summary`, `verification evidence`, and `risk notes`.
- Each later review stage must evaluate only the declared handoff inputs plus declared constraints.

## Timeout Fallback Rules
- You must treat two consecutive timeouts as two timeouts in the same claude -p call chain.
- When one timeout occurs, you must wait 10 seconds before the next claude -p invocation in the same call chain.
- When two consecutive timeouts occur in the same call chain, you must switch to a two-session fallback flow.
- In fallback flow, you must preserve implementation and review steps and must not skip either step.
- When timeout cause is unknown, you must report cause: unknown and `retry: on-hold`.

## Two-Session Fallback Flow Rules
- Session A must perform implementation-only actions and produce patch candidate output.
- Session A output must follow the source-review or result-review handoff structure defined in `## Split-Flow Handoff Rules`.
- Session B must perform review-only actions on Session A output and produce accept/reject decision.
- Session A and Session B must not share one combined prompt.
- Final execution decision must use Session B decision as review gate.

## Logging Delegation Rules
- You must record timeout notices with timestamp, attempted request summary, timeout count, and fallback decision.
- You must delegate Claude Collaboration Log field format to `../tool-usage-management/claude-cross-review-protocol.md`.

# Must NOT

## Prohibited Runtime Behavior
- You must not inject full CLAUDE.md content using `claude -p "$(cat ... )"`.
- You must not skip implementation or review just because timeout occurred.
- You must not retry immediately with identical conditions after timeout or error.
- You must not redefine cross-review log schema that belongs to `claude-cross-review-protocol.md`.

# Flow

## Runtime Control Flow
1. Resolve CLAUDE.md path and classify request as heavy or light.
2. Run healthchecks for heavy requests.
3. Extract review profile block from `CLAUDE.md`.
4. Validate prompt-size limits and request scope.
5. When limits are exceeded, split into investigation, implementation, and review stages with required handoff structures.
6. Run claude -p request.
7. If timeout occurs, apply cooldown and timeout fallback rules.
8. If repeated timeout occurs in the same call chain, switch to two-session fallback flow.
9. Record timeout notice and delegate review-log schema to `claude-cross-review-protocol.md`.

# Definition of Done

## Verification
- Rules in ## Path Resolution Rules are satisfied before runtime execution.
- Rules in ## Request Classification Rules are satisfied before healthcheck decision.
- Rules in ## Timeout and Healthcheck Rules are satisfied before heavy requests.
- Rules in ## CLAUDE.md Profile Injection Rules are satisfied for each invocation.
- Rules in ## Prompt Size Control Rules and ## Split-Flow Handoff Rules are satisfied or split flow is applied.
- Rules in ## Timeout Fallback Rules and ## Two-Session Fallback Flow Rules are satisfied for timeout cases.
- Rules in ## Logging Delegation Rules are satisfied.
- No prohibited behavior in # Must NOT occurred.
