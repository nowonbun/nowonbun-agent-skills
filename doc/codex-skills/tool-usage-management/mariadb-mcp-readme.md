# mariadb-mcp 스킬 설명

## 목적
- MariaDB MCP를 사용할 때 연결 범위, 권한 한계, SQL 안전 조건을 먼저 검증하도록 만든 스킬이다.

## 핵심 규칙
- 현재 MCP 권한 범위를 먼저 확인한다.
- SQL은 한 번에 한 문장만 실행한다.
- 파라미터가 섞이면 parameterized input을 우선한다.
- 스키마나 테이블 이름은 증거 없이 단정하지 않는다.
- 결과 보고에는 SQL 목적과 결과 의미를 같이 적는다.

## 사용 시 주의
- 현재 권한이 read-only이면 write SQL을 시도하면 안 된다.
- 스키마 suffix 규칙 같은 것은 실제 증거 없이는 `unverified`로 둬야 한다.
