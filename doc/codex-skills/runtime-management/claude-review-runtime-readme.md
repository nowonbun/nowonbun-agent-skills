# claude-review-runtime 스킬 설명

## 목적
- Claude cross-review를 항상 수행해야 하는 기본 실행 래퍼로 동작하도록 만든 runtime 스킬이다.

## 핵심 규칙
- 변경 작업에서는 기본적으로 Claude review를 mandatory로 본다.
- 리뷰 단계는 `plan-review`, `source-review`, `result-review`, `re-review`를 사용한다.
- 실행 전에는 CLI 가용성과 응답성을 확인한다.
- 각 단계별 입력 범위를 다르게 준비한다.

## 사용 시 주의
- 더 이상 `cross-review: not required`를 기본값처럼 쓰면 안 된다.
- 계획이 없으면 review 생략이 아니라 blocked로 처리해야 한다.
