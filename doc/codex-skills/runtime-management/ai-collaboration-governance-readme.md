# ai-collaboration-governance 스킬 설명

## 목적
- Claude MCP 협업에서 timeout, fallback, 요청 크기 제한, 단계별 handoff 규칙을 일관되게 적용하기 위한 runtime 제어 문서다.

## 핵심 규칙
- 무거운 요청 전에는 `nowonbun_claude` 응답성 확인을 먼저 수행한다.
- 요청이 크면 단계 분리와 handoff 구조를 유지해 review 품질을 보존한다.
- `CLAUDE.md`에서 review profile을 추출하거나 파생해 MCP 요청에만 주입한다.
- timeout이 발생해도 구현 단계와 검토 단계를 생략하지 않는다.

## 사용 시 주의
- prompt-size 제어는 CLI 길이 제한 대응이 아니라 MCP 요청 크기와 응답 지연 제어 기준으로 해석해야 한다.
- 동일 조건의 즉시 재시도는 금지되고, 연속 timeout이면 fallback 흐름으로 전환해야 한다.
