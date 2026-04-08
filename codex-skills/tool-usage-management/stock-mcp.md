---
name: stock-mcp
description: StockSearcher MCP 서버의 도구 목록과 호출 규칙을 확인해야 할 때 사용한다.
---

# StockSearcher MCP Skill

## 목적
StockSearcher MCP 도구를 정확한 파라미터와 형식으로 호출하도록 안내한다.

## 규칙
1. MCP 서버 경로는 `/mcp`이며, `webapp.py`에서 `FastMCP`로 정의된다.
1. 시장 코드는 `KR`, `JP`만 허용한다.
1. 파라미터 누락 시 오류가 발생하므로 필수 파라미터를 먼저 확인한다.

## 제공 MCP 툴
1. `list_stocks`
   - 목적: 시장별 종목 리스트 조회
   - 파라미터: `market` (optional, default `KR`)
   - 반환: `{code, name}` 배열
2. `stock_data`
   - 목적: 특정 종목의 시세/지표 시계열 조회
   - 파라미터: `market` (required), `code` (required), `limit` (optional, default 2000), `start_date` (optional), `end_date` (optional)
   - 반환: `STOCK_DATA_*` 테이블 컬럼 포함 행 배열
3. `list_predict_dates`
   - 목적: 예측 기준일 목록 조회
   - 파라미터: `market` (optional, default `KR`), `limit` (optional, default 120)
   - 반환: `YYYY-MM-DD` 날짜 배열
4. `predict_rows`
   - 목적: 특정 기준일의 예측 결과 조회
   - 파라미터: `market` (required), `as_of` (required)
   - 반환: `{data_cutoff, code, name, probability, open, close, low, high, volume}` 배열

## 오류/검증
1. `market`가 `KR/JP`가 아니면 오류가 발생한다.
1. `stock_data`는 `code`가 없으면 오류가 발생한다.
1. `predict_rows`는 `as_of`가 없으면 오류가 발생한다.

## 산출물 형식
1. 결론을 먼저 제시한다.
1. 필요한 호출 예시를 bullet로 제공한다.
