# ai-collaboration-governance 스킬 설명

## 목적
- Claude 협업 시 timeout, fallback, prompt-size 제약을 통제하면서 계획/소스/결과 리뷰 단계를 안정적으로 연결하기 위한 스킬이다.

## 핵심 규칙
- 큰 요청은 분할한다.
- handoff 구조를 단계별로 고정한다.
- source-review와 result-review 입력 구조를 구분한다.
- REVIEW_PROFILE 마커가 없으면 현재 `CLAUDE.md` 본문 섹션에서 review profile을 파생한다.
- timeout이 나도 review 단계를 생략하지 않는다.

## 사용 시 주의
- plan/source/result review 입력을 한 프롬프트로 뭉개면 안 된다.
- timeout 발생 시 동일 조건 즉시 재시도하면 안 된다.
