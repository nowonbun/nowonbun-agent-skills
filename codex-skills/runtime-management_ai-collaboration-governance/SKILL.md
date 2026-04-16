---
name: ai-collaboration-governance
description: Codex와 Claude를 조율하는 담당자는 Claude MCP 협업 중에 확정적 타임아웃, 대체 처리 및 요청 크기 제어를 반드시 적용해야 합니다.
---

# AI Collaboration Governance

# Must

## Scope
- 구현 또는 검토 워크플로를 위해 Claude MCP 협업을 실행할 때 이 문서를 반드시 적용해야 합니다.
- 타임아웃 방지, 대체 처리 및 요청 크기 제어에 대한 런타임 제어에 이 문서를 반드시 적용해야 합니다.

## Source of Truth
- 이 문서는 `./SKILL.md`에 있는 Claude 협업 런타임 제어, 타임아웃 처리, 대체 흐름 및 요청 크기 제어를 규정합니다. 검토 결과 정규화, 협업 로그 필드 스키마 또는 기록 의무는 규정하지 않습니다.
- `../tool-usage-management_claude-cross-review-protocol/SKILL.md`는 검토 로그 필드, 검토 출력 형식 및 발견 정규화 결정에 대한 유일한 기준이 되는 문서입니다. Claude 검토 결과를 기록하는 방법을 결정할 때 이 문서를 참조하십시오. 런타임 시간 초과 또는 대체 제어 결정을 내릴 때는 이 문서를 참조하지 마십시오.
- `CLAUDE`는 검토 정책 프로필 내용 및 검토 우선순위에 대한 유일한 기준이 되는 문서입니다. Claude 요청에 어떤 검토 관심사 또는 우선순위를 포함시킬지 결정할 때 이 문서를 참조하십시오. 런타임 전송 제어를 내릴 때는 이 문서를 참조하지 마십시오.

## Path Resolution Rules
- 검토 정책 경로는 반드시 `CLAUDE`로 해석해야 합니다.
- `CLAUDE`를 읽을 수 없거나 누락된 경우 실행을 중지하고 `cross-review: blocked (reason: review policy path unavailable)` 오류를 보고해야 합니다.

## Request Classification Rules
- 다음 조건 중 하나 이상이 충족될 경우 요청을 '헤비(heavy)'로 분류해야 합니다.
  - 프롬프트 텍스트가 2000자를 초과하는 경우
  - 요청 항목이 5개를 초과하는 경우
  - 대상 파일이 3개를 초과하는 경우
  - MCP 참조가 포함된 경우
- 위의 헤비 조건 중 어느 것도 충족되지 않을 경우 요청을 '라이트(light)'로 분류해야 합니다.

## Timeout and Healthcheck Rules
- 각 `mcp_servers.nowonbun_claude` 검토 호출에 대해 최대 5분의 대기 시간을 적용해야 합니다.
- 모든 헤비 요청 전에 `nowonbun_claude` 응답성 검사를 실행해야 하며, 이 검사의 출력은 `OK`여야 합니다.
- 두 상태 점검 중 하나라도 5분 이내에 완료되지 않으면 헤비 요청을 중지하고 타임아웃 대체 흐름을 시작해야 합니다.

## CLAUDE Profile Injection Rules
- 검토 위치, 핵심 검토 목표, 주요 검토 고려 사항, 검토 결과 기대치, 검토 결정 지침, 인코딩 및 문서 검토 규칙, 금지된 검토 행위를 정의하는 현재 `CLAUDE` 섹션에서 검토 프로필을 도출해야 합니다.
- 추출 또는 도출된 검토 프로필만 `mcp_servers.nowonbun_claude` 요청에 포함해야 합니다.
- 프로필 추출 및 도출이 모두 실패하거나 빈 내용이 생성되는 경우, 실행을 중지하고 프로필 입력 누락을 보고해야 합니다.
- 추출된 프로필 길이가 1200자를 초과하는 경우, 다음 우선순위를 유지하여 압축해야 합니다.
  1. 금지 사항
  2. 심각도
  3. 초점 축
  4. 출력 모드
- 압축 중에 `Prohibited`, `Severity` 또는 역할 섹션을 삭제해서는 안 됩니다.

## Request Size Control Rules
- 각 `mcp_servers.nowonbun_claude` 요청은 다음 제한을 준수해야 합니다.
  - 프롬프트 텍스트: 2000자 이하
  - 요청 항목: 5개 이하
  - 대상 파일: 3개 이하
- 요청이 제한을 초과하는 경우, 조사, 구현 및 검토 단계로 분할해야 합니다.
- 하나의 요청에서 참조되는 MCP 유형은 2개 이하로 제한해야 합니다.

## Split-Flow Handoff Rules
- 계획 검토 단계의 출력은 `findings`, `candidate files`, `constraints` 구조를 사용하여 구현 단계의 입력으로 전달해야 합니다.
- 소스 검토 단계의 입력에는 `changed files`, `diff scope summary`, `expected invariants`이 포함되어야 합니다.
- 결과 검토 단계의 입력에는 `changed files`, `change summary`, `verification evidence`, `risk notes`이 포함되어야 합니다.
- 각 후속 검토 단계에서는 선언된 핸드오프 입력과 선언된 제약 조건만 평가해야 합니다.

## Timeout Fallback Rules
- 연속된 두 번의 타임아웃은 동일한 `mcp_servers.nowonbun_claude` 호출 체인에서 발생한 두 번의 타임아웃으로 처리해야 합니다.
- 한 번의 타임아웃이 발생하면 동일한 호출 체인에서 다음 `mcp_servers.nowonbun_claude` 호출 전에 10초 동안 대기해야 합니다.
- 동일한 호출 체인에서 연속된 두 번의 타임아웃이 발생하면 두 세션으로 구성된 대체 흐름으로 전환해야 합니다.
- 대체 흐름에서는 구현 및 검토 단계를 유지해야 하며, 어느 단계도 건너뛰어서는 안 됩니다.
- 타임아웃 원인을 알 수 없는 경우, 원인: 알 수 없음 및 `retry: on-hold`을 보고해야 합니다.

## Two-Session Fallback Flow Rules
- 세션 A는 구현 작업만 수행하고 패치 후보 출력을 생성해야 합니다.
- 세션 A의 출력은 `## 분할 흐름 인계 규칙`에 정의된 소스 검토 또는 결과 검토 인계 구조를 따라야 합니다.
- 세션 B는 세션 A의 출력에 대해 검토 작업만 수행하고 승인/거부 결정을 생성해야 합니다.
- 세션 A와 세션 B는 하나의 통합 프롬프트를 공유해서는 안 됩니다.
- 최종 실행 결정은 세션 B의 결정을 검토 게이트로 사용해야 합니다.

## Logging Delegation Rules
- 타임아웃 알림은 타임스탬프, 시도된 요청 요약, 타임아웃 횟수 및 대체 결정과 함께 기록해야 합니다.
- Claude 협업 로그 필드 형식은 `../tool-usage-management_claude-cross-review-protocol/SKILL.md`에 위임해야 합니다.

# Must NOT
- 하나의 `mcp_servers.nowonbun_claude` 요청에 전체 CLAUDE 콘텐츠를 삽입해서는 안 됩니다. 
- 타임아웃이 발생했다는 이유만으로 구현 또는 검토 단계를 건너뛰어서는 안 됩니다.
- 타임아웃 또는 오류 발생 후 동일한 조건으로 즉시 재시도해서는 안 됩니다.
- `../tool-usage-management_claude-cross-review-protocol/SKILL.md`에 속하는 교차 검토 로그 스키마를 재정의해서는 안 됩니다.

# Flow
1. CLAUDE 경로를 확인하고 요청을 무거운 요청 또는 가벼운 요청으로 분류합니다.
2. 무거운 요청에 대한 상태 점검을 실행합니다.
3. `CLAUDE`에서 검토 프로필 블록을 추출합니다.
4. 프롬프트 크기 제한 및 요청 범위를 검증합니다.
5. 제한을 초과하는 경우, 필요한 인수인계 구조를 사용하여 조사, 구현 및 검토 단계로 분할합니다.
6. `mcp_servers.nowonbun_claude` 요청을 실행합니다.
7. 타임아웃이 발생하면 쿨다운 및 타임아웃 대체 규칙을 적용합니다.
8. 동일한 호출 체인에서 타임아웃이 반복적으로 발생하는 경우, 두 세션 대체 흐름으로 전환합니다. 
9. 타임아웃 알림을 기록하고 검토 로그 스키마를 `../tool-usage-management_claude-cross-review-protocol/SKILL.md`로 위임합니다.

# Definition of Done

## Verification
- 런타임 실행 전에 `## Path Resolution Rules`의 규칙이 충족됩니다.
- 상태 확인 결정 전에 `## Request Classification Rules`의 규칙이 충족됩니다.
- 과부하 요청 전에 `## Timeout and Healthcheck Rules`의 규칙이 충족됩니다.
- 각 호출에 대해 `## CLAUDE Profile Injection Rules`의 규칙이 충족됩니다.
- `## Request Size Control Rules` 및 `## Split-Flow Handoff Rules`의 규칙이 충족되거나 분할 흐름이 적용됩니다.
- 타임아웃 사례에 대해 `## Timeout Fallback Rules` 및 `## Two-Session Fallback Flow Rules`의 규칙이 충족됩니다.
- `## Logging Delegation Rules`의 규칙이 충족됩니다.
- `# Must NOT`이 발생하지 않아야 합니다.
