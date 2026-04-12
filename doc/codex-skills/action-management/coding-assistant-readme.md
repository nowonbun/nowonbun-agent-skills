# coding-assistant 스킬 설명

## 목적
- 코드·설정·개발 문서 변경에서 Codex 구현과 Claude 검토를 분리하고, 검토 경로와 검증 보고를 일관되게 유지하기 위한 실행 문서다.

## 핵심 규칙
- 변경을 비파괴/파괴적으로 먼저 분류한다.
- 실행 영향이 있는 문서·설정 변경도 Claude review mandatory gate를 적용한다.
- Claude review는 `plan-review` → `source-review` → `result-review` 순서를 기본으로 따른다.
- 최종 보고에는 실제 사용한 review execution path와 fallback 여부를 함께 적는다.

## 사용 시 주의
- 문서 변경이라도 실행 규칙을 바꾸면 no-review 작업으로 처리하면 안 된다.
- review 실패나 timeout을 숨기지 말고 대체 검증 흐름과 잔여 리스크를 남겨야 한다.
