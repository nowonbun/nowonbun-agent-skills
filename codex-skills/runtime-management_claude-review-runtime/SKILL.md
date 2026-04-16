---
name: claude-review-runtime
description: Claude MCP 교차 검토를 실행해야 하는 에이전트는 이 런타임 스킬을 사용하여 적용 가능성을 판단하고, 로컬 사전 검사를 수행한 후, 실행을 Claude 교차 검토 프로토콜로 넘겨야 합니다.
---

# Claude Review Runtime

# Must

## Scope
- 코드, 문서, 구성 또는 규칙 변경에 대한 Claude MCP 교차 검토가 필요한 작업에는 이 문서를 적용해야 합니다.
- 이 문서는 Claude 검토 실행을 위한 런타임 진입 래퍼로 간주해야 하며, 검토 로그 구조 또는 발견 정규화에 대한 단일 정보 소스로 간주해서는 안 됩니다.

## Applicability Rules
- 관리되는 하네스 범위 내에서 코드, 문서, 구성, 규칙 문서 또는 워크플로 정의를 변경하는 모든 작업에 이 문서를 사용해야 합니다.
- 호출 전에 검토 단계를 `plan-review`, `source-review`, `result-review` 또는 `re-review`로 분류해야 합니다.
- `plans-review`는 실행 가능한 구현 계획이 준비된 후 실행이 시작되기 전에 수행되는 첫 번째 검토를 의미합니다.
- `source-review`는 소스 수정 사항이 발생한 후 최종 완료 보고 전에 수행되는 검토를 의미합니다.
- `result-review`는 파일 변경, 문서 변경, 구성 변경 또는 규칙 변경과 같은 구체적인 결과가 실행된 후 수행되는 검토를 의미합니다.
- `re-review`는 이전 Claude 발견 사항에 대한 수정 변경 사항이 적용된 후 수행되는 반복 검토를 의미합니다.
- 작업에 계획 및 실행이 포함된 경우 `plans-review`를 먼저 실행해야 합니다.
- 작업에서 소스 파일이 변경되는 경우 완료 보고 전에 `source-review`를 실행해야 합니다.
- 실행에서 구체적인 결과가 발생한 경우 결과가 나온 후 `result-review`를 실행해야 합니다.
- 실행 가능한 계획이 아직 없는 경우 검토 시작을 중지하고 `cross-review: blocked (reason: no actionable plan)`을 보고해야 합니다.

## Source of Truth
- 이 문서는 `./SKILL.md`에 명시된 Claude 리뷰 런타임 진입 조건, 리뷰 단계 적용 가능성, 로컬 사전 검사 및 프로토콜 인계 동작을 규정합니다. Claude 발견 정규화, 협업 로그 스키마 또는 이력 레코드 생성 기준은 규정하지 않습니다.
- `../tool-usage-management_claude-cross-review-protocol/SKILL.md`는 Claude 호출 구조, 필수 리뷰 축, 발견 정규화 및 협업 로그 형식에 대한 유일한 정보 출처입니다. 런타임 진입 성공 후 리뷰 호출 구조 및 보고 방식을 결정할 때 이 문서를 참조하십시오. 단계 적용 가능성 또는 로컬 사전 검사 결정에는 이 문서를 참조하지 마십시오.
- `../skill-management_skill-modify-history/SKILL.md`는 이 런타임 스킬 또는 프로토콜을 수정할 때 이력 레코드 의무 사항에 대한 유일한 정보 출처입니다. 수정 사항을 이력 아티팩트에 기록해야 하는지 여부 및 방법을 결정할 때 이 문서를 참조하십시오. Claude 리뷰 시작 동작에는 이 문서를 참조하지 마십시오.

## Local Preflight Rules
- Claude MCP를 호출하기 전에 현재 환경에서 `mcp_servers.nowonbun_claude` 서버를 사용할 수 있는지 확인해야 합니다.
- Claude MCP를 호출하기 전에 `mcp_servers.nowonbun_claude` 서버를 통해 최소한의 응답성 검사를 실행해야 하며, 이 검사는 정확한 출력으로 `OK`를 요구합니다.
- MCP 가용성 검사에 실패하면 Claude 검토를 중지하고 `cross-review: blocked (reason: claude mcp unavailable)`를 보고해야 합니다.
- 응답성 검사에 실패하면 Claude 검토를 중지하고 `cross-review: blocked (reason: claude mcp unresponsive)`를 보고해야 합니다.

## Input Preparation Rules
- Claude를 호출하기 전에 현재 검토 단계를 정의해야 합니다.
- 프로토콜 흐름을 호출하기 전에 검토 목표와 대상 경로를 준비해야 합니다.
- `plan-review`의 경우, 검토 목표에 구현 계획, 예상 범위, 승인 기준 및 제외된 작업을 포함해야 합니다.
- `source-review`의 경우, 검토 목표에 변경된 소스 경로, 차이점 범위 요약, 예상 불변 요소 및 해결되지 않은 위험 요소를 포함해야 합니다.
- `result-review`의 경우, 검토 목표에 변경된 경로, 주장된 결과, 가능한 경우 검증 결과 및 알려진 제한 사항을 포함해야 합니다.
- `re-review`의 경우, 검토 목표에 이전 NG 요약, 수정 사항 및 해결되지 않은 항목을 포함해야 합니다.
- 대상에 `.md`, `.txt` 또는 기타 텍스트 문서가 포함된 경우, 검토 목표에 UTF-8 무결성 및 텍스트 보존 검사를 추가해야 합니다.
- 런타임 요청 크기 제어를 충족할 수 있도록 요청 본문을 충분히 간결하게 유지해야 합니다.
- 파일 경로와 검토 의도를 전달해야 하며, 파일을 직접 읽는 것으로 충분한 경우 전체 차이점이나 전체 파일 내용을 MCP 요청에 붙여넣어서는 안 됩니다.

## Execution Rules
- 로컬 사전 검사가 성공하면, 실제 Claude 호출 및 보고는 `../tool-usage-management_claude-cross-review-protocol/SKILL.md`에 정의된 규칙을 따라야 합니다.
- 이 하네스의 실행 진입점으로 `mcp_servers.nowonbun_claude`를 사용해야 합니다.
- 호출 실패 시, `../tool-usage-management_claude-cross-review-protocol/SKILL.md`에 정의된 재시도 및 차단 상태 규칙을 따라야 합니다.
- 각 `plan-review`, `source-review`, `result-review` 또는 `re-review` 후에는 활성 대화에서 사용자에게 검토 결과를 보고해야 합니다.
- 사용자에게 표시되는 보고서에는 `phase`, `cross-review status`, `summary`, `key findings` 및 `next action`가 포함되어야 합니다.

# Must NOT
- `../tool-usage-management_claude-cross-review-protocol/SKILL.md`에 이미 포함된 정규화 규칙을 재정의해서는 안 됩니다.
- `../tool-usage-management_claude-cross-review-protocol/SKILL.md`에 이미 포함된 협업 로그 형식을 재정의해서는 안 됩니다.
- 이 런타임 스킬이 선택된 실행 항목인 경우 로컬 MCP 가용성 검사를 건너뛰어서는 안 됩니다.
- 대상 파일이 로컬에서 읽을 수 있는 경우 MCP 요청을 통해 전체 차이점 페이로드 또는 전체 파일 본문을 전송해서는 안 됩니다.

# Flow
1. `## Applicability Rules`에 따라 필수 검토 단계 순서를 결정합니다.
2. 검토 단계를 `plans-review`, `source-review`, `result-review` 또는 `re-review`로 분류합니다.
3. 로컬 MCP 가용성 및 응답성 검사를 실행합니다.
4. 해당되는 경우 검토 목표, 대상 경로 및 문서 무결성 검사를 준비합니다.
5. 실행을 `../tool-usage-management_claude-cross-review-protocol/SKILL.md`로 인계합니다.
6. 프로토콜에 정의된 출력 및 로그 형식을 사용하여 결과를 보고하고, 필요한 사용자 대상 대화 요약도 제공합니다.

# Definition of Done

## Verification
- `## Applicability Rules`에 따라 필수 적용 여부가 결정되었습니다.
- 실행 전에 검토 단계가 분류되었습니다.
- 프로토콜 인계 전에 로컬 MCP 사전 검사가 성공했거나, 차단 결과가 보고되었습니다.
- 텍스트 문서 검토 목표에는 적용 가능한 경우 UTF-8 무결성 및 텍스트 보존 검사가 포함됩니다.
- 호출, 정규화 및 보고 규칙은 중복된 로컬 규칙 텍스트 없이 `../tool-usage-management_claude-cross-review-protocol/SKILL.md`에 위임되었습니다.
- 각 필수 검토 단계에 대한 사용자에게 표시되는 검토 요약이 보고되었습니다.
- 실행 중 `# Must NOT`에 명시된 금지된 동작이 발생하지 않았습니다.
