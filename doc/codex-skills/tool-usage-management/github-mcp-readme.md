# github-mcp 스킬 설명

## 목적
- GitHub MCP를 쓸 때 로컬 git 작업과 원격 GitHub API 작업을 분리하고, write 전에 저장소 식별자와 대상 ID를 검증하도록 만든 스킬이다.

## 핵심 규칙
- 커밋/푸시는 git CLI이고, 이슈/PR/리뷰/브랜치/원격 파일 작업은 GitHub MCP다.
- write 전에는 `owner`, `repo`, PR 번호, 이슈 번호, branch, comment ID 같은 대상 식별자를 확인한다.
- 현재 상태가 필요한 작업은 read-before-write를 먼저 한다.
- 결과 보고에는 target ID, 실행 결과, 실패 이유, 재실행 필요 여부를 포함한다.

## 사용 시 주의
- GitHub MCP와 git CLI를 같은 범주로 설명하면 안 된다.
- remote delete, merge, close 같은 작업을 기본적으로 저위험으로 보면 안 된다.
