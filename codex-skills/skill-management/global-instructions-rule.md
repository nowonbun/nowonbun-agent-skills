---
name: global-instructions-rule
description: global_instructions.md 문서를 새로 작성하거나 개정할 때 헌법 문서 기준과 구조를 적용한다.
---

# Must

## Scope
- 이 문서는 `global_instructions.md`를 작성하거나 개정할 때 적용한다.
- 목적은 전역 원칙 문서를 개별 스킬 설명과 분리해 헌법 문서로 유지하는 것이다.

## Out of Scope
- `AGENTS.md` 작성 규칙은 이 문서에서 다루지 않는다.
- 개별 스킬 문서 작성 규칙은 `skill-create-rule.md`를 따른다.
- 일반 참고 문서나 설명 문서에는 이 문서를 직접 적용하지 않는다.

## Structure
1. `global_instructions.md`는 헌법 문서로 작성한다.
2. 전역 원칙, 응답 스타일, 판단 우선순위, 금지 규칙, 사용자 프로필을 포함한다.
3. 개별 스킬의 세부 절차, 예시, MCP 파라미터 목록을 직접 길게 적지 않는다.
4. 개별 문서가 우선해야 하는 경우 문서명과 적용 범위를 명시한다.
5. 전역 규칙 충돌 시 우선순위를 명시한다.
6. 구조적 관계나 적용 우선순위가 복잡하면 PlantUML(`puml`)로 표현한다.

## Rule Writing
1. 문장은 전역 원칙 중심으로 짧고 단정적으로 쓴다.
2. 모든 하위 문서가 공통으로 따라야 하는 내용만 남긴다.
3. 특정 폴더나 특정 프로젝트에만 적용되는 규칙은 넣지 않는다.
4. 개별 스킬에서 다시 설명할 내용을 중복 정의하지 않는다.

## Source of Truth
1. 전역 응답 원칙과 사용자 프로필의 단일 원본은 `global_instructions.md`다.
2. 개별 스킬 작성 규칙의 단일 원본은 `skill-create-rule.md`다.
3. `AGENTS.md` 작성 규칙의 단일 원본은 `agents-rule.md`다.

# Do NOT

## Overreach
- 폴더별 예외 규칙을 `global_instructions.md`에 넣지 않는다.
- 개별 스킬 트리거와 상세 절차를 `global_instructions.md`에 넣지 않는다.
- 특정 MCP의 파라미터와 반환 형식을 전역 문서에 복제하지 않는다.

## Duplication
- 이미 다른 문서가 원본인 규칙을 다시 원문 수준으로 복제하지 않는다.
- 같은 원칙을 여러 이름으로 반복 정의하지 않는다.

# Flow

## Authoring
1. 전역으로 유지해야 하는 규칙만 추린다.
2. 로컬 규칙과 스킬 전용 규칙을 분리한다.
3. 헌법 문서에 남길 항목만 구조화한다.
4. 우선 문서와 단일 원본을 명시한다.
5. 완료 후 `Verification`과 필요 시 `Monitoring`을 작성한다.

# Definition of Done

## Verification
- `global_instructions.md`가 헌법 문서 역할을 명확히 가진다.
- 전역 원칙, 우선순위, 금지 규칙, 사용자 프로필이 포함된다.
- 로컬 규칙과 스킬 세부 절차가 분리돼 있다.
- 단일 원본과 우선순위가 필요한 규칙에 원본 문서가 명시된다.
- 중복 정의가 최소화돼 있다.

## Monitoring
- 전역 규칙이 반복 충돌하거나 로컬 문서에서 반복 재정의되면 구조를 다시 점검한다.
- 스킬 목록 변경, 문서 우선순위 변경, 전역 금지 규칙 변경이 생기면 `global_instructions.md`와 하위 문서의 정합성을 다시 확인한다.

