---
name: stock-mcp
description: Engineers using the StockSearcher MCP server must use this skill to validate market and date parameters, select the correct stock tool, and report query intent clearly.
---

# Stock MCP Skill

# Must

## Scope
- You must apply this document when using StockSearcher MCP tools for stock lists, price history, prediction dates, or prediction rows.
- You must choose the tool based on the exact data need instead of reusing one tool for every stock question.

## Source of Truth
- This document is the single source of truth for StockSearcher MCP usage rules in `codex-skills/tool-usage-management/stock-mcp.md`.
- `D:/work/nowonbun-harness/AGENTS.md` and `codex-skills/runtime-management/work-runtime.md` are the single source of truth for shared MCP validation and stop conditions.

## Tool Selection Rules
- You must use `list_stocks` when the task is to discover stock codes or names by market.
- You must use `stock_data` when the task requires historical price or volume rows for one stock code.
- You must use `list_predict_dates` when the task requires available prediction cutoff dates.
- You must use `predict_rows` when the task requires prediction rows for one market and one cutoff date.

## Parameter Validation Rules
- You must validate `market` before every stock MCP call when the tool accepts it.
- You must use only supported market codes confirmed by current MCP behavior.
- You must validate `code` before `stock_data`.
- You must validate `as_of` before `predict_rows`.
- You must validate date strings in `YYYY-MM-DD` format when date parameters are supplied.

## Query Framing Rules
- You must state whether the user wants discovery data, historical data, available prediction dates, or prediction results before calling the tool.
- You must state the market explicitly when the task could apply to more than one market.
- You must state row limits or date windows when the requested history range would otherwise be ambiguous.

## Output Rules
- You must report which stock MCP tool was used and why.
- You must summarize the returned rows in plain language instead of dumping raw output only.
- You must mark unsupported market or missing required parameter cases as blocked with the exact missing field.

# Must NOT

## Prohibited Stock MCP Behavior
- You must not call `predict_rows` without both `market` and `as_of`.
- You must not call `stock_data` without both `market` and `code`.
- You must not assume unsupported markets beyond the ones confirmed by current MCP behavior.
- You must not use prediction data as if it were price-history data.

# Flow

## Execution Flow
1. Identify whether the request is discovery, price history, prediction-date lookup, or prediction-row lookup.
2. Select the matching stock MCP tool.
3. Validate `market` and all required parameters for that tool.
4. Execute the tool call.
5. Report tool choice, returned result meaning, and any blocked parameter reason.

# Definition of Done

## Verification
- The selected stock MCP tool matches the user data need.
- Required parameters are validated before execution.
- Market support is evidence-backed.
- Final output explains tool choice and result meaning.
