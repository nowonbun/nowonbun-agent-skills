# claude-cross-review-protocol 스킬 설명

## 목적
- Claude 교차 검토 요청 형식, finding 정규화, 협업 로그 형식을 `nowonbun_claude` MCP 호출 기준으로 고정하기 위한 프로토콜 문서다.

## 핵심 규칙
- 각 검토 호출마다 `phase`, `objective`, `target paths`, `acceptance criteria`, `exclusion scope`를 명시한다.
- 호출 경로는 하네스 내부에서 `mcp_servers.nowonbun_claude`로 고정한다.
- 결과는 normalized finding과 `Claude Collaboration Log`로 기록한다.
- 텍스트 문서 검토에는 UTF-8 무결성과 본문 보존 확인을 추가한다.

## 사용 시 주의
- blocked, error, unverified 상태를 섞으면 안 된다.
- 합의된 항목은 새 위험이 없으면 다시 쓰지 말고 NG만 출력해야 한다.
