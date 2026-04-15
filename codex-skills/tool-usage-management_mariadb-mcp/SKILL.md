---
name: mariadb-mcp
description: Engineers using the MariaDB MCP server must use this skill to verify connection scope, respect read-only permissions, and validate SQL before execution.
---

# MariaDB MCP Skill

# Must

## Scope
- You must apply this document when using MariaDB MCP tools for database health checks, permission checks, or SQL queries.
- You must treat MariaDB MCP as a constrained database interface with explicit permission boundaries.

## Source of Truth
- This document governs MariaDB connection-scope checks, SQL validation, and read/write permission handling in `./SKILL.md`; it does not govern shared workspace stop conditions, delegated runtime controls, or general skill-document format rules.
- `AGENTS` is the single source of truth for workspace execution triggers and workflow stop conditions; consult it when deciding whether a MariaDB MCP task is allowed to proceed inside the current workspace workflow, not for SQL validation or connection-scope rules.
- `../runtime-management_work-runtime/SKILL.md` is the single source of truth for shared MCP validation, shared stop conditions, and shared reporting controls delegated by AGENTS; consult it when deciding common runtime checks that apply before MCP execution, not for MariaDB-specific query or permission rules.

## Connection and Permission Rules
- Before running SQL, you must verify server reachability or permission summary when scope or capability is relevant to the task.
- You must treat the active MariaDB MCP connection as scoped to database `stock` when current MCP responses confirm that database.
- You must treat the current MariaDB MCP permissions as read-only when MCP responses show `select: true` and all write permissions as false.

## Query Safety Rules
- You must write SQL as one explicit statement per call.
- You must use parameterized inputs when user-controlled values are injected into SQL.
- You must validate table name, filter columns, and row-volume expectation before query execution.
- You must keep queries inside the current permission boundary and expected result size.

## Schema and Naming Rules
- You must verify table naming patterns against actual schema evidence before assuming them.
- You must treat market-specific stock tables as suffix-based only when current schema evidence confirms that convention.
- You must mark schema assumptions as `unverified` when you cannot verify them from query results or current MCP responses.

## Output Rules
- You must report the executed SQL purpose before showing results.
- You must summarize result meaning and row-count impact after execution.
- When a query cannot be executed because of permission or validation limits, you must report the block reason and next action.

# Must NOT

- You must not attempt `INSERT`, `UPDATE`, `DELETE`, DDL, or multi-statement execution when current permissions do not allow them.
- You must not assume schema names, table names, or market suffixes without evidence.
- You must not run unrestricted queries when filter or row-limit expectations are undefined.
- You must not present inferred schema details as verified facts.

# Flow

1. Verify connection scope and permission boundary when relevant.
2. Define the SQL purpose and expected result shape.
3. Validate table names, filters, and row-volume expectation.
4. Execute one read-only SQL statement within permission limits.
5. Report result meaning, row-count impact, and any block reason.

# Definition of Done

## Verification
- Connection scope and permission boundary are identified before risky or ambiguous SQL use.
- SQL purpose, target tables, and filters are explicit.
- The query stays within read-only and single-statement limits.
- Schema assumptions are evidence-backed or marked `unverified`.
- Output includes purpose, result meaning, and block reason when applicable.
