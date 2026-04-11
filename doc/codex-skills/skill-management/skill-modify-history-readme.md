# skill-modify-history 스킬 설명

## 목적
- 규칙 문서 수정 시 history 생성 조건과 cross-review 의무를 같이 관리하기 위한 스킬이다.

## 핵심 규칙
- trigger가 맞으면 daily history를 먼저 만든다.
- skill-scoped history와 daily history를 분리한다.
- 이제 cross-review는 기본 mandatory다.
- `plan-review`, `source-review`, `result-review`, `re-review` 단계를 필요한 순서로 기록해야 한다.

## 사용 시 주의
- 더 이상 “사용자가 요청했을 때만 review”라는 설계를 쓰면 안 된다.
- mandatory review를 못 돌리면 not required가 아니라 blocked로 남겨야 한다.
