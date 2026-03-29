# AGENTS.md

## 목적
- 이 저장소는 에이전트 작업용 지침/스킬 문서를 관리하는 문서 저장소다.
- 산출물은 대부분 `*.md`이며, 규칙 문서의 일관성, 충돌 방지, 재사용성이 핵심이다.

## 우선순위
1. 규칙 충돌 방지
2. 문서 일관성
3. 재사용 가능성
4. 최소 변경

## 작업 원칙
- 답변과 작업 보고는 항상 한국어로 한다.
- 결론을 먼저 쓰고, 그 다음 근거를 적는다.
- 추측을 사실처럼 쓰지 않는다.
- 기존 문서를 읽지 않고 새 규칙을 추가하지 않는다.
- 변경은 필요한 파일에만 최소 범위로 적용한다.

## 필수 절차
1. 수정 대상 문서를 먼저 읽는다.
2. 같은 주제의 인접 문서가 있으면 충돌 여부를 확인한다.
3. 새 규칙 추가 시 우선순위와 적용 범위를 명확히 적는다.
4. 링크/참조 경로가 있으면 수정 후 다시 확인한다.
5. 문서 작성 후 형식 일관성을 점검한다.

## 저장소 성격
이 저장소는 소스(source) 저장소다. 여기 있는 파일은 직접 Codex나 Claude에서 읽히지 않는다.
배포 후 실제 도구가 읽는 위치는 `~/.codex/skills/<파일명에서 .md 제거>/SKILL.md` 또는 `~/.claude/skills/<파일명에서 .md 제거>/SKILL.md`다.
Claude에서 사용자가 실제 경로를 `~/.claude/skils/...`로 운영하면 그 경로로 대체한다.
배포 절차는 `init-workspace-skills.md`를 따른다.
아래 스킬 문서 항목의 배포 경로 표기는 모두 위 원칙을 따른다.

- `global_instructions.md`: 전역 공통 지침 (배포 대상: 프로젝트 루트 `global_instructions.md`)
- `ai-agent.md`, `automation.md`, `coding-assistant.md`, `engineer.md`, `research.md`: 역할/상황별 지침
- `claude-review.md`: Claude CLI 리뷰 규칙
- `github-mcp.md`, `mariadb-mcp.md`, `stock-mcp.md`: MCP 사용 규칙
- `stock-analysis.md`, `reality-check.md`: 분석 및 검증 프레임
- `skill-create-rule.md`: 스킬 작성 규칙
- `markdown-safe-writing.md`: Markdown/문서 작성 시 UTF-8 저장, 셸 입력 손상 방지, 검증 절차 규칙
- `init-workspace-skills.md`: 워크스페이스/프로젝트에 공통 지침과 스킬 시트를 복사·갱신하는 초기화 규칙
- `skills-설명-정리.md`: Codex/Skills/MCP 구조 메모 (참조용, 배포 대상 없음)
- `list.md`, `reference.txt`: 레퍼런스 목록 (배포 대상 없음)

## 문서 선택 기준
아래는 소스 파일 기준이다. 배포 후에는 `~/.codex/skills/<이름>/SKILL.md` 또는 `~/.claude/skills/<이름>/SKILL.md` 경로를 사용한다. Claude에서 실제 경로가 `~/.claude/skils/...`면 그쪽으로 대체한다.

- 전역 응답 원칙, 사용자 호칭, 답변 스타일, 공통 판단 기준: `global_instructions.md`
- AI 에이전트 설계, 오케스트레이션, MCP 구조, 상태 관리, 관측 가능성: `ai-agent.md`
- 코딩 구현 협업 및 검토 절차: `coding-assistant.md`
- Claude CLI 리뷰 호출 절차, 실패 처리, 보고 형식: `claude-review.md`
- 반복 작업 자동화, 스크립트, CI/CD: `automation.md`
- 일반 소프트웨어 설계, 구현, 디버깅: `engineer.md`
- 조사형 분석, 배경 정리, 쟁점 구조화: `research.md`
- 주식 분석: `stock-analysis.md`
- 과도한 낙관이나 편향 검증: `reality-check.md`
- GitHub 작업 규칙: `github-mcp.md`
- MariaDB MCP 조회 규칙: `mariadb-mcp.md`
- StockSearcher MCP 조회/예측 규칙: `stock-mcp.md`
- 스킬 작성 규칙: `skill-create-rule.md`
- Markdown/문서 작성 시 한글 인코딩 안전 규칙: `markdown-safe-writing.md`
- 프로젝트별 공통 지침/스킬 초기화 및 동기화: `init-workspace-skills.md`

## 문서 작성 규칙
- 새 문서는 반드시 UTF-8로 저장한다.
- 가능하면 아래 구조를 강제한다.
  1. 목적
  2. 규칙
  3. 절차 또는 체크리스트
  4. 산출물 형식
- 지침 문서는 명령형으로 작성한다.
- 같은 의미의 규칙을 다른 표현으로 중복 작성하지 않는다.
- 감정 표현, 추상 표현, 과도한 수식어를 제거한다.
- 예시는 복붙해 재사용 가능한 형태로 쓴다.

## 더 엄격한 수정 규칙
- 기존 문서와 충돌 검토 없이 새 규칙을 추가하지 않는다.
- 파일명 변경은 참조 파일까지 함께 정리할 수 있을 때만 한다.
- 하나의 규칙을 여러 파일에 복제할 경우, 원본 문서를 어디로 둘지 먼저 정한다.
- 역할별 문서와 공통 문서의 책임 범위를 섞지 않는다.
- 링크/참조가 깨질 가능성이 있는 수정은 검증 없이 완료로 보고하지 않는다.

## 검증 규칙
- 아래를 최소 검증으로 본다.
  1. 제목/목차/번호 포맷 일관성 확인
  2. 인접 문서와 규칙 충돌 여부 확인
  3. `list.md`, `reference.txt`, 다른 md에서의 참조 경로 확인
- 검증을 못 한 항목은 답변에 명시한다.

## 실행/확인 명령어
```powershell
# 저장소 상태 확인
Get-ChildItem -Force

git status --short

git diff -- AGENTS.md README.md *.md

# 문서 검색
rg -n "MCP|규칙|목적|산출물 형식" .

# 파일 내용 확인
Get-Content .\AGENTS.md
Get-Content .\README.md
```

## 금지 사항
- 검증되지 않은 운영 절차를 사실처럼 문서화하지 않는다.
- 중복 규칙을 복붙으로 늘리지 않는다.
- 개인 비밀정보, 토큰, 실제 계정 정보를 문서에 넣지 않는다.
- 한 번에 저장소 전체 문서를 대량 포맷팅하지 않는다.

## 권장 응답 형식
- 결론
- 수정 내용
- 검증 결과
- 남은 이슈
