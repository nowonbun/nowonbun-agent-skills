---
name: skill-modify-history
description: 기대치 불일치 후 기술 또는 관리 문서를 수정하는 담당자는 이력 생성 동의를 확인하고 승인된 경우 원인, 수정 사항 및 예방 조치를 기록해야 합니다.
---

# Skill Modify History

# Must

## Scope
- 사용자 기대치와 실제 동작이 다르고, 이에 따라 스킬, 관리 또는 구성 규칙 문서를 수정해야 하는 경우 이 문서를 적용해야 합니다.
- 이 문서는 스킬 마크다운 형식 디자인이 아닌, 이력 생성 동의 절차 및 생성 시점 기준에 적용해야 합니다.

## Source of Truth
- 이 문서는 이력 기록 생성 동의 절차, 필수 콘텐츠 섹션 및 일별 생성 기준을 규정합니다. 스킬 문서 마크다운 구조, 서문 형식 또는 관련 아티팩트 요구 사항은 규정하지 않습니다.
- `../skill-management_skill-create-rule/SKILL.md`는 스킬 문서 구조, 서문 및 관련 아티팩트 요구 사항에 대한 유일한 기준 문서입니다. 스킬 문서 자체에 포함되어야 하는 내용을 결정할 때 이 문서를 참조해야 하며, 이력 기록 생성 시점이나 내용을 결정할 때는 참조하지 마십시오.

## History Artifact Types
- `daily history`는 `history/skill_YYYYMMDD.md`를 의미합니다.
- `skill-scoped history`는 `history/<relative-skill-path>/<skill-name>/` 아래의 파일을 의미합니다.
- `daily history`와 `skill-scoped history`는 서로 다른 아티팩트 유형으로 취급해야 합니다.
- 일별 인시던트 집계에는 `daily history`를 사용해야 합니다.
- 스킬별 개정 추적에는 `skill-scoped history`를 사용해야 합니다.

## Daily History Trigger Rules
- 규칙 문서를 편집하기 전에 일별 히스토리 생성 후보인지 여부를 결정해야 합니다.
- 아래 트리거 중 하나 이상이 참일 경우 사용자에게 `history/skill_YYYYMMDD.md` 파일 생성 여부를 확인해야 합니다.
  - 스킬 목록 추가, 삭제 또는 이름 변경
  - 스킬 설명 변경
  - 경로 표준 변경
  - 일관성 규칙 추가 또는 수정
  - 사용자가 보고한 누락된 절차
- 사용자가 이력 생성을 승인한 경우에만 `history/skill_YYYYMMDD.md` 파일을 생성해야 합니다.
- 사용자가 이력 생성을 거부한 경우 이력 파일을 생성하지 말고 최종 실행 보고서에 `history-consent: declined`를 기록해야 합니다.
- 모든 트리거가 거짓일 경우, 최종 실행 보고서에 `daily-history-trigger: no-op`을 기록해야 합니다.

## Required Daily History Content
- 필수 일일 기록 파일에는 다음 섹션이 포함되어야 합니다.
  - `Purpose`
  - `Incident Summary`
  - `Root Cause`
  - `Impact`
  - `Changes Applied`
  - `Recurrence Prevention Rules`
  - `Checklist`
  - `Conclusion`

## Recording Rules
- 상세 원인을 작성하기 전에 한 줄로 된 불일치 요약을 작성해야 합니다.
- "발생 원인"과 "변경 사항"은 서로 다른 섹션으로 구분해야 합니다.
- 수정된 파일 경로를 추상화 없이 정확하게 나열해야 합니다.
- 재발 방지 규칙은 실행 가능한 프로시저로 작성해야 합니다.
- 다음 유사 작업에서 재사용할 수 있는 체크리스트 항목을 작성해야 합니다.
- 히스토리 파일은 UTF-8 형식으로 저장해야 합니다.
- 사용자가 승인한 히스토리 생성을 최종 다듬기 단계로 미루어서는 안 됩니다.
- 최종 보고 전에 `today's modified rule document list`과 `today's generated history files`을 대조해야 합니다.

## Skill-Scoped History Language Rule
- `history/<relative-skill-path>/<skill-name>/` 폴더에 기록할 때는 해당 폴더에 있는 가장 최근의 히스토리 파일과 동일한 언어를 사용해야 합니다.
- 해당 폴더에 히스토리 파일이 없는 경우 한국어를 사용해야 합니다.

## Cross-Review Requirement Rule
- 이 하네스에서 다루는 모든 스킬, 거버넌스, 구성, 설정, 코드 및 문서 변경 사항에 대해 교차 검토를 실행해야 합니다.
- 실행 가능한 계획이 수립된 후 실행을 시작하기 전에 `plan-review`를 실행해야 합니다.
- 소스 파일이 수정된 후 최종 완료 보고서를 생성하기 전에 `source-review`를 실행해야 합니다.
- 실행 결과가 확정된 후에는 `result-review`를 실행해야 합니다.
- 이전 오류(NG)에 대한 수정 사항이 적용된 후에는 `re-review`를 실행해야 합니다.
- 필수 교차 검토를 완료할 수 없는 경우 `cross-review: blocked`를 보고해야 합니다.

## Outputs
- daily-history 트리거 중 하나라도 참이고 사용자가 이력 생성을 승인한 경우 `history/skill_YYYYMMDD.md` 파일이 생성됩니다.
- 수정된 규칙 문서의 업데이트된 파일 목록이 생성됩니다.
- daily-history 트리거 중 하나라도 참이고 사용자가 이력 생성을 거부한 경우 최종 실행 보고서에 `history-consent: declined`가 표시됩니다.
- daily-history 트리거가 모두 거짓인 경우 최종 실행 보고서에 `daily-history-trigger: no-op`이 표시됩니다.
- 교차 검토가 필요한 경우 교차 검토 결과 로그가 생성됩니다.

# Must NOT

## Prohibited Recording Behavior
- "실수였습니다"라는 문구만으로 사건 기록을 종결해서는 안 됩니다.
- 이력 기록에서 수정된 파일 경로를 누락해서는 안 됩니다.
- 사용자가 이력 생성을 승인한 경우, 트리거가 활성화된 날에 규칙 문서 수정을 완료하기 전에 `history/skill_YYYYMMDD.md` 파일을 생성해야 합니다.
- 이 문서의 이력 기준을 다른 문서에서 독립적인 규칙 세트로 중복해서 사용해서는 안 됩니다.

# Flow

## Incident Recording Flow
1. 예상과 실제의 불일치를 한 줄로 요약합니다.
2. 규칙 파일을 작성하기 전에 일일 이력 트리거를 평가합니다.
3. 트리거가 참이면 사용자에게 이력 생성 여부를 확인합니다.
4. 사용자가 승인하면 `history/skill_YYYYMMDD.md` 파일을 즉시 생성하고, 사용자가 거부하면 최종 실행 보고서에 `history-consent: declined`를 기록합니다.
5. 트리거가 거짓이면 최종 실행 보고서에 `daily-history-trigger: no-op`을 기록합니다.
6. 관련 규칙 문서를 수정합니다.
7. 이력 파일이 생성된 경우 근본 원인, 변경 사항 및 예방 규칙을 기록 아티팩트에 기록합니다.
8. `## Cross-Review Requirement Rule`에 정의된 필수 교차 검토 단계를 실행하고 결과를 최종 실행 보고서에 기록합니다.
9. 완료 보고 전에 수정된 규칙 파일과 생성된 기록 파일 또는 `history-consent: declined` 보고 상태를 교차 검증합니다.

# Definition of Done

## Verification
- 규칙 문서 편집 전에 `## Daily History Trigger Rules`의 검사가 완료되었습니다.
- 트리거 결과와 사용자 동의 결과에 따라 `## Outputs`에 명시된 필수 출력물 또는 `history-consent: declined` 보고 상태가 생성되었습니다.
- 일일 기록 생성 시 `## Required Daily History Content`의 내용 요구 사항이 충족되었습니다.
- `## Recording Rules`의 쓰기 제약 조건이 충족되었습니다.
- `## Skill-Scoped History Language Rule`의 언어 제약 조건이 충족되었습니다.
- 필수 단계 적용을 포함하여 `## Cross-Review Requirement Rule`의 실행 및 보고 동작이 충족되었습니다.
