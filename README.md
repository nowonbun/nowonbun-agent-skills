이 저장소는 개인 소스와 로컬 에이전트 문서를 함께 관리하는 저장소다.
=============================

> 소스 종류는 C#, Java, Javascript, PHP다.
> C# 소스는 개인 가계부, 테스트용 WinForms, 회사 업무 시스템 프레임워크, WebSocket, 웹서버 등이 포함된다.
> 개인 가계부는 현재 운영 중이며 URL은 "http://household.nowonbun.com" 이다.

> Java는 JSP/Servlet 기반으로 만들어졌다. 현재는 마이그레이션 시스템, CSS 웹 목업 등 REST API 성격의 소스가 있다.

> Javascript는 기본 프레임워크 용도다.

> PHP는 개인 가계부용 데이터 연결 계층이다. REST API와 비슷한 역할을 한다.

# C#

* AisWebServices - 회사 업무 시스템 프레임워크 (미완성)
* DataChecker - URL 연결 도구
* Household - 개인 가계부 1차 버전 (미완성)
* Household2 - 개인 가계부 2차 버전 (미완성)
* RefreshRouter - 스크래핑 엔진 -> 공유기 새로고침 시스템 (미완성)
* WebScraping - 스크래핑 엔진 -> 공유기 새로고침 시스템 (미완성)
* WorkAdminProgram - HTTP 및 WebSocket 서버 (미완성)

# Java

* DataTransfer - (미완성)
* HouseholdData - (미완성)
* Other clean up - 참고용 소스
* WebMock - CSS 및 Javascript 소스 (미완성)

# Javascript

# PHP

* Household - 개인 가계부용 데이터 연결 계층. REST API와 비슷한 역할을 한다.

## Agent Skill Documents

이 저장소에는 로컬 에이전트 스킬 문서와 운영 가이드도 함께 보관한다.

- `AGENTS.md`: 이 저장소 작업 시 우선순위와 최소 변경 원칙
- `global_instructions.md`: 전역 동작 규칙
- `CLAUDE.md`: Claude용 시스템 지침 문서
- `ai_agent.md`: AI 에이전트 설계 스킬
- `automation.md`: 반복 작업 자동화, 스크립트, CI/CD 스킬
- `coding_assistant.md`: Claude 협업, 리뷰, 대체 검증 스킬
- `engineer.md`: 소프트웨어 설계, 구현, 디버깅 스킬
- `research.md`: 조사형 분석, 배경 정리, 쟁점 구조화 스킬
- `stock_analysis.md`: 주식 분석 스킬
- `reality_check.md`: 과도한 낙관과 편향 검증 스킬
- `claude-review.md`: Claude CLI 리뷰 호출, 실패 처리, 보고 형식
- `github-mcp.md`: GitHub MCP 사용 규칙
- `mariadb-mcp.md`: MariaDB MCP 조회 규칙
- `stock-mcp.md`: Stock MCP 조회·예측 규칙
- `skill_create_rule.md`: 스킬 작성 규칙
- `skills-설명-정리.md`: Claude/Skills/MCP 구조 메모
- `list.md`: 관련 저장소 및 참고 리포지토리 목록

### Claude review policy

- 코드, 문서, 설정 변경 시 Claude 리뷰를 먼저 시도한다.
- PowerShell에서는 `claude.ps1` 대신 `claude.cmd`를 우선 사용한다.
- 샌드박스 실행이 실패하면 권한 상승으로 재시도하고 결과를 보고한다.
- 상세 워크플로와 대체 검증 규칙은 `coding_assistant.md`를 따른다.
- Claude CLI 리뷰 호출 방식, 실패 처리, 보고 형식은 `claude-review.md`를 따른다.
