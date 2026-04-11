# AGENTS.md (Workspace Layer)

## 1) Scope and Folder Responsibilities

### 1.1 Governed Folder Roles
- `D:/work`
  - role: Execution area for workspace operation rules
  - ownership boundary: Only trigger execution and result reporting defined in this file.
- `D:/work/nowonbun-harness/codex-skills/skill-management`
  - role: Reference source for constitution and skill governance
  - ownership boundary: Reference-only unless explicit edit request is provided.
- `D:/work/nowonbun-harness/codex-skills/runtime-management`
  - role: Definition area for shared runtime controls
  - ownership boundary: Keep workflow-specific rules in AGENTS.md, and manage only shared controls here.

### 1.2 Workspace Layer Prohibitions
- Workflows that define exact-match triggers must not start with partial matches.
- Path-specific workflows must not run before folder responsibilities are defined.
- Workflows without stop conditions must not be published.

### 1.3 Runtime Rule Delegation
- Shared runtime controls (trigger-collision handling, MCP pre-validation, shared stop conditions, and shared report formats) must be referenced from `D:/work/nowonbun-harness/codex-skills/runtime-management/work-runtime.md`.
- Before workflow execution, the delegated runtime file must be verified as existing and readable.
- If the delegated runtime file is missing or inaccessible, execution must stop with a Workflow Failure Report.

### 1.4 Skill and MCP Minimum Usage Policy
- Skill usage must follow task-fit selection: apply only the minimum required skills for the current workflow.
- MCP tools must not be called before verifying required source-of-truth IDs/URLs defined by each workflow.
- Before MCP write operations, required parameters must be validated for existence, format, and target consistency.
- After MCP write operations, reports must include target id, execution result, failure reason (if any), and re-run necessity.

## 2) Workspace Workflows

### 2.1 Constitution Consistency Review Workflow
- exact trigger phrase: `정합성 확인`
- source-of-truth files:
  - `D:/work/nowonbun-harness/global_instructions.md`
  - `D:/work/nowonbun-harness/AGENTS.md`
  - `D:/work/nowonbun-harness/codex-skills/runtime-management/work-runtime.md`
- execution order:
  1. Verify that every source-of-truth file exists, is readable, and resolves to one canonical real path.
  2. Verify that the delegated runtime file is populated before using delegated shared controls.
  3. Compare global-layer rules, workspace-layer rules, and delegated runtime controls against the priority model.
  4. Report `success`, `failure`, or `no-op` with evidence lines or execution logs.
- stop conditions:
  - A required source-of-truth file is missing, unreadable, empty when delegated content is required, or not canonical.
  - The requested target documents are ambiguous.
  - Active rules conflict without a defined resolver.
- failure handling:
  - Emit a Workflow Failure Report with `finding`, `evidence`, and `next action`.
- re-run and duplicate-prevention:
  - If the same file set was already reviewed and no file changed after the last review, report `no-op`.
  - Re-run only after a target file or delegated runtime file changes.

### 2.2 Constitution Alignment Revision Workflow
- exact trigger phrase: `정합성 수정`
- source-of-truth files:
  - `D:/work/nowonbun-harness/global_instructions.md`
  - `D:/work/nowonbun-harness/AGENTS.md`
  - `D:/work/nowonbun-harness/codex-skills/runtime-management/work-runtime.md`
- execution order:
  1. Run the `정합성 확인` workflow on the target files.
  2. Prepare the minimum in-scope patch that resolves confirmed inconsistencies.
  3. Write only the approved target files and any delegated runtime file required by this AGENTS document.
  4. Re-run the `정합성 확인` workflow and report the post-write result.
- stop conditions:
  - The requested write scope is ambiguous.
  - A target path is outside the declared instruction scope.
  - The delegated runtime file is required for consistency repair but cannot be resolved to one canonical real path.
- failure handling:
  - Emit a Workflow Failure Report with `finding`, `evidence`, and `next action`.
- re-run and duplicate-prevention:
  - If the files are already compliant, report `no-op` and do not rewrite them.
  - Re-run only when a new inconsistency is detected or the user expands the revision scope.

### 2.3 Shared Runtime Control Update Workflow
- exact trigger phrase: `runtime 규칙 갱신`
- source-of-truth file:
  - `D:/work/nowonbun-harness/codex-skills/runtime-management/work-runtime.md`
- execution order:
  1. Verify that the runtime file path is canonical and writable within the declared instruction scope.
  2. Update only shared runtime controls delegated by this AGENTS document.
  3. Re-run the `정합성 확인` workflow for constitution files that reference the runtime file.
- stop conditions:
  - The runtime file path is ambiguous or outside the declared instruction scope.
  - The requested change attempts to add workflow-specific rules to the delegated runtime file.
- failure handling:
  - Emit a Workflow Failure Report with `finding`, `evidence`, and `next action`.
- re-run and duplicate-prevention:
  - If the delegated controls already match the requested state, report `no-op`.
  - Re-run only after the delegated runtime content changes.
