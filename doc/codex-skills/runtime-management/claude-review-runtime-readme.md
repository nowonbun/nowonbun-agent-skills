# claude-review-runtime 스킬 설명

## 목적
- Claude 교차 검토를 CLI 대신 `mcp_servers.nowonbun_claude` MCP로 실행할 때 적용하는 runtime 진입 규칙이다.

## 핵심 규칙
- 문서, 설정, 규칙, 코드 변경에서는 Claude review를 기본 검토 단계로 유지한다.
- 검토 단계는 `plan-review`, `source-review`, `result-review`, `re-review`를 사용한다.
- 실제 호출 전에 `nowonbun_claude` MCP 가용성과 최소 응답성(`OK`)을 확인한다.
- 텍스트 문서가 포함되면 UTF-8 무결성과 본문 보존 확인을 검토 목표에 포함한다.

## 사용 시 주의
- 실행 경로만 MCP로 바꾸고, finding 정규화와 로그 형식은 protocol 문서에 계속 위임해야 한다.
- 실행 가능한 계획이 없으면 review를 건너뛰지 말고 blocked로 보고해야 한다.
