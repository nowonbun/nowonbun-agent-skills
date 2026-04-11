# Shared Runtime Controls

## 1) Trigger-Collision Handling
- Exact trigger phrase matches must take precedence over non-exact or inferred matches.
- If two or more workflows define the same exact trigger phrase, execution must stop and a Stop-condition Confirmation Request must be issued.
- A workflow that requires a path-specific trigger must not run when the resolved target path falls outside the governed folder defined by `AGENTS.md`.

## 2) MCP Pre-validation
- Before any MCP tool call, the workflow must verify the source-of-truth file, ID, URL, or target reference required by that workflow.
- Before any MCP write operation, the workflow must validate parameter existence, format, and target-ID consistency for the selected server.
- If source verification or parameter validation cannot be completed, execution must stop before the MCP call.

## 3) Shared Stop Conditions
- Execution must stop when a required input is missing.
- Execution must stop when a required input is ambiguous.
- Execution must stop when active rules conflict without a defined resolver.
- Execution must stop when a target path cannot be normalized to one canonical real path.
- Execution must stop when a write action would affect content outside the declared instruction scope.
- Execution must stop when a required source-of-truth file is missing, unreadable, or empty when delegated controls are required.

## 4) Shared Report Formats

### Workflow Failure Report
- finding: what failed
- evidence: files, logs, or MCP responses that prove the failure
- next action: the next step, including the re-run condition

### Stop-condition Confirmation Request
- blocked by: the blocking rule or condition
- requested decision: the explicit user decision required to continue
- impact: the consequence of each available decision path

## 5) Text-document Write Verification
- Text-document writes delegated by this workspace must use UTF-8.
- Post-write verification must check that the file can be read as UTF-8 and must separate console-rendering issues from file-content corruption.
