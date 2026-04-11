# claude-cross-review-protocol 스킬 설명

## 목적
- Claude cross-review의 입력 형식, 결과 정규화, 로그 형식을 고정하기 위한 프로토콜 스킬이다.

## 핵심 규칙
- 리뷰 단계는 `plan-review`, `source-review`, `result-review`, `re-review`를 지원한다.
- 각 invocation마다 phase, objective, target paths, acceptance criteria를 명시한다.
- 결과는 normalized finding과 collaboration log로 남긴다.
- source 수정이 있으면 `source-review`를 별도 단계로 다룬다.

## 사용 시 주의
- `cross-review: not required`를 skip 기본값으로 사용하면 안 된다.
- blocked와 error, unverified를 섞으면 안 된다.
