# nowonbun-harness

Codex/Claude 기반 로컬 AI 작업 환경에서 사용하는 하네스 문서, 스킬 문서, 런타임 규칙, 보조 스크립트를 관리하는 저장소다.

현재 이 저장소의 중심은 애플리케이션 소스 코드 보관이 아니라, **에이전트 실행 규칙과 작업 자산 관리**다.

## 개요

이 저장소에는 다음 성격의 파일이 함께 있다.

- 전역 규칙 문서: `global_instructions.md`
- 워크스페이스 규칙 문서: `AGENTS.md`
- Claude 리뷰 기준 문서: `CLAUDE.md`
- Codex 스킬 문서 모음: `codex-skills/`
- 참고 문서: `doc/`
- 배포 스크립트: `script/`
- 변경 이력/보조 보관본: `history/`, `backup_skills/`, `claude-skills/`

즉, 이 저장소는 “프로젝트 설명서”라기보다 **AI 에이전트 운영 체계와 스킬 자산을 관리하는 하네스 저장소**에 가깝다.

## 핵심 문서

### `global_instructions.md`
- 시스템 정체성
- 전역 원칙
- 안전 경계
- 우선순위 모델

### `AGENTS.md`
- 워크스페이스 범위와 폴더 책임
- 실행 트리거
- 워크플로
- 중단 조건과 보고 형식

### `CLAUDE.md`
- Claude를 리뷰 AI로 사용할 때의 검토 기준
- 리뷰 우선순위와 보고 기대치

## 디렉터리 구조

```text
nowonbun-harness/
├─ global_instructions.md
├─ AGENTS.md
├─ CLAUDE.md
├─ README.md
├─ codex-skills/
│  ├─ action-management/
│  ├─ runtime-management/
│  ├─ skill-management/
│  ├─ stock-management/
│  ├─ tool-usage-management/
│  └─ vocabulary-management/
├─ doc/
├─ script/
├─ history/
├─ backup_skills/
└─ claude-skills/
```

## `codex-skills` 구성

`codex-skills/`는 역할별 문서를 나눠 관리한다.

- `action-management/`: 작업 수행 방식
  - 예: `ai-agent.md`, `automation.md`, `coding-assistant.md`, `engineer.md`, `research.md`
- `runtime-management/`: 실행 중 공통 제어 규칙
  - 예: `work-runtime.md`, `claude-review-runtime.md`, `markdown-safe-writing.md`
- `skill-management/`: 스킬/거버넌스 규칙
  - 예: `constitution-rule.md`, `skill-create-rule.md`, `skill-check-rule.md`
- `tool-usage-management/`: 외부 도구/MCP 사용 규칙
  - 예: `github-mcp.md`, `mariadb-mcp.md`, `stock-mcp.md`
- `vocabulary-management/`: 용어 정의와 해석 기준
- `stock-management/`: 주식 분석 관련 문서

## 스크립트

`script/`에는 Codex 스킬 배포용 스크립트가 있다.

- `install-codex-skills.ps1`: Windows PowerShell용
- `install-codex-skills.sh`: macOS/Linux용

이 스크립트는 저장소의 스킬 문서를 Codex 스킬 디렉터리 구조에 맞게 복사하고, 필요한 설정 연결을 돕기 위한 용도다.

## 작업 시 참고

이 저장소를 수정할 때는 보통 아래 문서를 먼저 확인하면 된다.

1. `global_instructions.md`
2. `AGENTS.md`
3. 필요 시 `CLAUDE.md`
4. 해당 작업과 직접 관련된 `codex-skills/...` 문서

## 저장소 성격 요약

- 목적: 로컬 AI 작업 하네스 운영
- 중심 자산: 규칙 문서, 스킬 문서, 런타임 제어 문서, 배포 스크립트
- 주 사용 시나리오:
  - Codex/Claude 작업 규칙 관리
  - 스킬 문서 작성 및 배포
  - MCP 사용 규칙 정리
  - 리뷰/검증 절차 유지

## 비고

기존 README에 있던 개인 언어별 소스 저장소 설명은 현재 루트 구조와 맞지 않아 제거했다.  
현재 루트 기준으로는 하네스 운영 문서와 스킬 체계가 저장소의 주된 성격이다.
