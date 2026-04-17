# AGENTS.md (Workspace Layer)

## 1) Scope and Folder Responsibilities

### 1.1 Governed Folder Roles
- `D:/work`
  - 역할: 워크스페이스 운영 규칙 실행 영역
  - 소유권 경계: 이 파일에 정의된 트리거 실행 및 결과 보고만 관리합니다.
- `D:/work/nowonbun-harness/codex-skills/skill-management`
  - 역할: 구성 및 스킬 관리 참조 소스
  - 소유권 경계: 명시적인 편집 요청이 없는 한 참조 전용입니다.
- `D:/work/nowonbun-harness/codex-skills/runtime-management_work-runtime`
  - 역할: 공유 런타임 컨트롤 정의 영역
  - 소유권 경계: 워크플로별 규칙은 AGENTS.md에 유지하고, 여기서는 공유 컨트롤만 관리합니다.

### 1.2 Workspace Layer Prohibitions
- 정확히 일치하는 트리거를 정의하는 워크플로는 부분 일치로 시작해서는 안 됩니다.
- 경로별 워크플로는 폴더 책임이 정의되기 전에 실행되어서는 안 됩니다.
- 중지 조건이 없는 워크플로는 게시해서는 안 됩니다.

### 1.3 Runtime Rule Delegation
- 공유 런타임 제어(트리거 충돌 처리, 공유 검토 참조 처리, MCP 사전 유효성 검사, 공유 중지 조건, 공유 보고서 형식 및 텍스트 문서 쓰기 검증)는 `D:/work/nowonbun-harness/codex-skills/runtime-management_work-runtime/SKILL.md`에서 참조해야 합니다.
- 워크플로 실행 전에 위임된 런타임 파일이 존재하고 읽을 수 있는지 확인해야 합니다.
- 위임된 런타임 파일이 없거나 접근할 수 없는 경우 워크플로 실패 보고서와 함께 실행이 중지되어야 합니다.

### 1.4 Skill and MCP Minimum Usage Policy
- 스킬 사용은 작업 적합성 선택을 따라야 합니다. 현재 워크플로에 필요한 최소 스킬만 적용해야 합니다.
- MCP 도구는 각 워크플로에서 정의된 필수 소스 ID/URL을 확인하기 전에 호출해서는 안 됩니다.
- MCP 쓰기 작업 전에 필수 매개변수의 존재 여부, 형식 및 대상과의 일관성을 검증해야 합니다.
- MCP 쓰기 작업 후 보고서에는 대상 ID, 실행 결과, 실패 사유(있는 경우) 및 재실행 필요성이 포함되어야 합니다.
- 워크플로에서 규칙 문서를 수정할 때는 `work-runtime`에 정의된 공유 검토 참조 규칙을 참조해야 합니다.

## 2) Workspace Workflows

### 2.1 Constitution Consistency Review Workflow
- 정확한 트리거 문구: `정합성 확인`
- 소스 오브 트루스 파일:
  - `D:/work/nowonbun-harness/global_instructions.md`
  - `D:/work/nowonbun-harness/AGENTS.md`
  - `D:/work/nowonbun-harness/codex-skills/runtime-management_work-runtime/SKILL.md`
- execution order:
  1. 모든 소스 오브 트루스 파일이 존재하고, 읽을 수 있으며, 하나의 정규화된 실제 경로로 확인되는지 확인합니다.
  2. 위임된 공유 컨트롤을 사용하기 전에 위임된 런타임 파일이 채워져 있는지 확인합니다.
  3. 글로벌 계층 규칙, 워크스페이스 계층 규칙 및 위임된 런타임 컨트롤을 우선순위 모델과 비교합니다.
  4. 성공, 실패 또는 작업 없음 결과를 증거 라인 또는 실행 로그와 함께 보고합니다.
- stop conditions:
  - 필수 원본 파일이 없거나, 읽을 수 없거나, 위임된 콘텐츠가 필요한 경우 비어 있거나, 표준 형식이 아닌 경우
  - 요청된 대상 문서가 모호한 경우
  - 정의된 해결 방법 없이 활성 규칙이 충돌하는 경우
- failure handling:
  - 결과, 증거 및 다음 조치를 포함하는 워크플로 실패 보고서를 생성합니다.
- re-run and duplicate-prevention:
  - 동일한 파일 세트를 이미 검토했고 마지막 검토 이후 파일이 변경되지 않은 경우 작업 없음(no-op)을 보고합니다.
  - 대상 파일 또는 위임된 런타임 파일이 변경된 후에만 재실행합니다.

### 2.2 Constitution Alignment Revision Workflow
- 정확한 트리거 문구: `정합성 수정`
- 주요 파일:
  - `D:/work/nowonbun-harness/global_instructions.md`
  - `D:/work/nowonbun-harness/AGENTS.md`
  - `D:/work/nowonbun-harness/codex-skills/runtime-management_work-runtime/SKILL.md`
- 실행 순서:
  1. 대상 파일에 대해 `정합성 확인` 워크플로를 실행합니다.
  2. 확인된 불일치를 해결하는 최소 범위 내 패치 계획을 준비합니다.
  3. 쓰기 실행 전에 `skill-modify-history` 및 `claude-review-runtime`에 참조된 쓰기 전 검토 요구 사항을 적용합니다.
  4. 승인된 대상 파일과 이 AGENTS 문서에서 요구하는 위임된 런타임 파일만 씁니다.
  5. `정합성 확인` 워크플로를 다시 실행하고 쓰기 후 결과를 보고합니다.
  6. 쓰기 실행 후, `skill-modify-history` 및 `claude-review-runtime`에 참조된 쓰기 후 검토 요구 사항을 적용하고 최종 결과를 보고합니다.
- 중지 조건:
  - 요청된 쓰기 범위가 모호합니다.
  - 대상 경로가 선언된 명령 범위 외부에 있습니다.
  - 위임된 런타임 파일이 일관성 복구에 필요하지만 하나의 정규화된 실제 경로로 확인되지 않습니다.
- 오류 처리:
  - `finding`, `evidence`, `next action`을 포함하는 워크플로 오류 보고서를 생성합니다.
- 재실행 및 중복 방지:
  - 파일이 이미 규정을 준수하는 경우 `no-op`을 보고하고 다시 작성하지 않습니다.
  - 새로운 불일치가 감지되거나 사용자가 수정 범위를 확장하는 경우에만 재실행합니다.

### 2.3 Shared Runtime Control Update Workflow
- 정확한 트리거 문구: `런타임 규칙 실행`
- 소스 파일:
  - `D:/work/nowonbun-harness/codex-skills/runtime-management_work-runtime/SKILL.md`
- 실행 순서:
  1. 런타임 파일 경로가 선언된 명령어 범위 내에서 정규적이고 쓰기 가능한지 확인합니다.
  2. 범위 내 최소 런타임 제어 패치 계획을 준비합니다.
  3. 쓰기 실행 전에 `skill-modify-history` 및 `claude-review-runtime`에 참조된 쓰기 전 검토 요구 사항을 적용합니다.
  4. 이 AGENTS 문서에서 위임된 공유 런타임 제어만 업데이트합니다.
  5. 런타임 파일을 참조하는 구성 파일에 대해 `정합성 확인` 워크플로를 다시 실행합니다.
  6. 쓰기 실행 후 `skill-modify-history` 및 `claude-review-runtime`에 참조된 쓰기 후 검토 요구 사항을 적용하고 최종 결과를 보고합니다.
- 중지 조건:
  - 런타임 파일 경로가 모호하거나 선언된 명령 범위를 벗어난 경우
  - 요청된 변경 사항이 위임된 런타임 파일에 워크플로별 규칙을 추가하려고 시도하는 경우
- 실패 처리:
  - '결과', '증거', '다음 조치'를 포함하는 워크플로 실패 보고서를 생성합니다.
- 재실행 및 중복 방지:
  - 위임된 컨트롤이 이미 요청된 상태와 일치하는 경우 '작업 없음'을 보고합니다.
  - 위임된 런타임 콘텐츠가 변경된 후에만 재실행합니다.
