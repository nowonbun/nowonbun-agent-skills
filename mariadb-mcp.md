---
name: mariadb-mcp
description: MariaDB MCP 서버 사용 규칙과 스키마 관례를 확인해야 할 때 사용한다.
---

# MariaDB MCP Skill

## 목적
MariaDB MCP 서버를 안전하게 사용하고 데이터베이스 관례를 준수한다.

## 규칙
1. 기본적으로 조회만 수행하고, 데이터 변경은 금지한다.
1. StockSearcher 관련 데이터베이스 이름은 `stock`이다.
1. 한국 주식 테이블은 postfix로 `_KR`을 사용한다.
1. 일본 주식 테이블은 postfix로 `_JP`를 사용한다.

## 산출물 형식
1. 수행 가능한 작업 범위를 먼저 명시한다.
1. 필요한 경우 간단한 조회 SQL 예시를 포함한다.
