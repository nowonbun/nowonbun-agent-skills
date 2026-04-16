---
name: work-runtime
description: 하네스 워크플로를 실행하는 에이전트는 공유 트리거, 유효성 검사, 중지, 보고 및 텍스트 쓰기 제어를 적용하기 위해 이 런타임 규칙을 사용해야 합니다.
---

# Work Runtime

# Must

## Scope
- 이 문서는 이 하네스 내의 `AGENTS`에서 위임된 공유 런타임 제어를 실행할 때 반드시 적용해야 합니다.
- 이 문서는 `AGENTS`에서 위임된 공유 트리거 우선순위, 공유 검토 참조, 공유 MCP 사전 유효성 검사, 공유 중지 조건, 공유 보고서 형식 및 공유 텍스트 문서 쓰기 검증에 대한 유일한 기준점으로 간주해야 합니다.
- 이 문서는 워크플로별 실행 순서, 도구별 매개변수 규칙 또는 Claude 검토 로그 스키마에 대한 기준점으로 간주해서는 안 됩니다.

## Source of Truth
- 이 문서는 `./SKILL.md`에 있는 공유 트리거 우선순위, 공유 검토 참조, 공유 MCP 사전 유효성 검사, 공유 중지 조건, 공유 보고서 형식 및 공유 텍스트 문서 쓰기 검증을 관리합니다. 워크플로별 실행 순서, 필수 검토 단계 순서 설계 또는 도구별 매개변수 규칙은 관리하지 않습니다.
- `../skill-management_skill-modify-history/SKILL.md`는 규칙 문서가 수정될 때 필수 검토 단계 요구 사항 및 일일 기록 트리거 처리와 관련된 유일한 기준 파일입니다. `plan-review`, `source-review`, `result-review`, `re-review` 또는 `history/skill_YYYYMMDD.md`가 필요한지 여부를 결정할 때 이 파일을 참조하십시오. 공유 런타임 트리거, 중지 또는 보고 제어에는 이 파일을 사용하지 마십시오.
- `../runtime-management_claude-review-runtime/SKILL.md`는 Claude 검토 시작, 로컬 사전 검사 및 차단 상태 처리와 관련된 유일한 기준 파일입니다. 필수 검토 단계가 시작되거나 실패해야 하는 방식을 결정할 때 이 파일을 참조하십시오. 공유 런타임 트리거, 중지 또는 보고 제어에는 이 파일을 사용하지 마십시오.
- `../tool-usage-management_claude-cross-review-protocol/SKILL.md`는 Claude 협업 로그 필드 및 리뷰 정규화에 대한 유일한 기준 문서입니다. 공유 런타임 제어 위임이 아닌 리뷰 출력 기록 방식을 결정할 때 이 문서를 참조하십시오.
- `../runtime-management_markdown-safe-writing/SKILL.md`는 여기에 정의된 공유 UTF-8 검증을 넘어 텍스트 문서 손상 복구 및 쓰기 경로 안전성 결정에 대한 유일한 기준 문서입니다. 공유 중지/보고 제어가 아닌 복구 또는 사고 처리 단계를 결정할 때 이 문서를 참조하십시오.

## Shared Trigger Rules
- 정확한 트리거 문구 일치는 정확하지 않거나 추론된 일치보다 우선합니다.
- 두 개 이상의 워크플로가 동일한 정확한 트리거 문구를 정의하는 경우 실행을 중지하고 중지 조건 확인 요청을 발행해야 합니다.
- 경로별 트리거가 필요한 워크플로는 해결된 대상 경로가 `AGENTS`로 정의된 관리 폴더 외부에 있는 경우 실행되어서는 안 됩니다.

## Shared Review Reference Rules
- 워크플로가 규칙 문서를 수정할 때, 필수 검토 단계 요구 사항 및 쓰기 실행 전후의 일일 기록 트리거 처리를 위해 `../skill-management_skill-modify-history/SKILL.md`를 참조해야 합니다.
- 워크플로가 Claude 검토 단계를 호출할 때, 검토 시작, 로컬 사전 검사 및 차단 상태 처리를 위해 `../runtime-management_claude-review-runtime/SKILL.md`를 참조해야 합니다.
- 워크플로가 Claude 검토 결과를 보고할 때, Claude 협업 로그 필드 및 정규화된 발견 출력에 대한 참조로 `../tool-usage-management_claude-cross-review-protocol/SKILL.md`를 반드시 포함해야 합니다.

## Shared MCP Pre-validation Rules
- 모든 MCP 도구 호출 전에 워크플로는 해당 워크플로에 필요한 원본 파일, ID, URL 또는 대상 참조를 검증해야 합니다.
- 모든 MCP 쓰기 작업 전에 워크플로는 선택한 서버에 대한 매개변수의 존재 여부, 형식 및 대상 ID 일관성을 검증해야 합니다.
- 원본 검증 또는 매개변수 유효성 검사를 완료할 수 없는 경우, MCP 호출 전에 실행을 중지해야 합니다.

## Shared Stop Conditions
- 필수 입력이 누락된 경우 실행을 중지해야 합니다.
- 필수 입력이 모호한 경우 실행을 중지해야 합니다.
- 정의된 해결자 없이 활성 규칙이 충돌하는 경우 실행을 중지해야 합니다.
- 대상 경로를 하나의 정규화된 실제 경로로 정규화할 수 없는 경우 실행을 중지해야 합니다.
- 쓰기 작업이 선언된 명령 범위 외부의 콘텐츠에 영향을 미치는 경우 실행을 중지해야 합니다.
- 위임된 제어가 필요한 경우, 필수 원본 파일이 없거나 읽을 수 없거나 비어 있는 경우 실행을 중지해야 합니다.

## Shared Report Format Rules

### Workflow Failure Report
- 발견 사항: 실패 원인
- 증거: 실패를 입증하는 파일, 로그 또는 MCP 응답
- 다음 작업: 재실행 조건을 포함한 다음 단계

### Stop-condition Confirmation Request
- 차단 원인: 차단 규칙 또는 조건
- 요청된 결정: 계속하기 위해 필요한 명시적인 사용자 결정
- 영향: 사용 가능한 각 결정 경로의 결과

## Text-document Write Verification
- 이 워크스페이스에서 위임된 텍스트 문서 쓰기는 UTF-8을 사용해야 합니다.
- 쓰기 후 검증은 파일이 UTF-8로 읽히는지 확인하고 콘솔 렌더링 문제와 파일 콘텐츠 손상을 구분해야 합니다.
- 위임된 작업 영역 범위에서 새로 생성된 보조 README 파일 및 기록 아티팩트에도 동일한 UTF-8 검증 요구 사항이 적용됩니다.

# Must NOT

## Scope Drift
- 이 문서에서 워크플로별 실행 순서를 정의해서는 안 됩니다.
- 도구 사용 스킬에 속하는 도구별 매개변수 규칙을 재정의해서는 안 됩니다.
- 참조된 원본 문서에서 이미 정의되어 있는 경우, Claude 검토 단계 순서 또는 Claude 협업 로그 스키마를 재정의해서는 안 됩니다.

## Trigger Execution
- 부분 일치, 접두사만 사용 또는 추론된 트리거에서 정확한 일치 워크플로를 시작해서는 안 됩니다.
- 경로 정규화에 실패한 후 경로 범위 워크플로를 실행해서는 안 됩니다.

# Flow
1. 위임된 공유 컨트롤을 사용하기 전에 `./SKILL.md` 파일을 읽을 수 있는지 확인합니다.
2. 공유 트리거 규칙 및 경로 경계 검사를 적용합니다.
3. 워크플로에서 규칙 문서를 수정하거나 Claude 검토를 호출할 때 공유 검토 참조를 적용합니다. 
4. MCP 호출 전에 공유 MCP 사전 유효성 검사를 적용합니다.
5. 쓰기 또는 기타 차단된 작업이 진행되기 전에 공유 중지 조건을 적용합니다.
6. 최종 보고 전에 공유 보고서 형식 및 UTF-8 검증을 적용합니다.

# Definition of Done

## Verification
- 문서에는 `name`과 `description`만 포함된 유효한 프론트매터가 있습니다.
- `AGENTS`에서 위임된 공유 런타임 제어는 워크플로별 실행 순서를 도입하지 않고 처리됩니다.
- 공유 검토 참조는 규칙 텍스트를 중복하지 않고 `../skill-management_skill-modify-history/SKILL.md`, `../runtime-management_claude-review-runtime/SKILL.md` 및 `../tool-usage-management_claude-cross-review-protocol/SKILL.md`를 가리킵니다.
- 공유 MCP 사전 유효성 검사, 중지 조건, 보고서 형식 및 UTF-8 검증 규칙은 실행 가능합니다. 
- `# Must NOT` 규칙은 범위 변경 및 잘못된 트리거 실행을 방지합니다.
