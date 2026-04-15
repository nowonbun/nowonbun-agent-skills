# work-runtime 스킬 설명

## 목적
- `work-runtime`은 AGENTS가 위임한 공통 runtime 제어 문서다.
- exact trigger 우선순위, 공통 MCP 사전 검증, 공통 중단 조건, 공통 보고 형식, UTF-8 검증을 담당한다.

## 담당 범위
- review phase 순서는 여기서 재정의하지 않고 `skill-modify-history`와 `claude-review-runtime`을 참조한다.
- Claude Collaboration Log 형식은 `claude-cross-review-protocol`을 따른다.

## 사용 시 주의
- workflow별 실행 순서를 이 문서에 직접 넣지 않는다.
- readme와 history도 UTF-8로 저장하고 파일 기준으로 검증한다.
