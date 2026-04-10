# Vocabulary Registry

## Entry Schema
- Required fields: `term`, `category`, `canonical meaning`, `decision rule`, `allowed values`, `prohibited interpretations`, `evidence source`.
- Category must be one of: `priority`, `time`, `scope`, `state`, `risk`, `action`, `report-status`.

## Term Entries

### Entry 1
- term: `should`
- category: `priority`
- canonical meaning: A recommended action that can be skipped only when rationale is recorded.
- decision rule: If an instruction uses `should` or `recommended`, execution may proceed without that action only when the skip rationale is written in the final report.
- allowed values: `follow`, `skip-with-rationale`
- prohibited interpretations: `optional-without-reason`, `equivalent-to-must`, `equivalent-to-must-not`
- evidence source: execution report text

### Entry 2
- term: `today`
- category: `time`
- canonical meaning: The calendar date at execution time in the active timezone.
- decision rule: Convert relative date words (`today`, `yesterday`, `tomorrow`) to `YYYY-MM-DD` before final execution decision and reporting.
- allowed values: `YYYY-MM-DD`
- prohibited interpretations: `server-unknown-timezone`, `leave-relative-expression`
- evidence source: runtime date command output or tool response

### Entry 3
- term: `must`
- category: `priority`
- canonical meaning: A mandatory requirement with no discretionary skip.
- decision rule: If an instruction uses `must` or `always`, execution must include that action unless a higher-priority explicit exception exists.
- allowed values: `execute-as-required`
- prohibited interpretations: `optional`, `recommended-only`, `skip-without-exception`
- evidence source: execution logs or output artifacts

### Entry 4
- term: `must not`
- category: `priority`
- canonical meaning: An unconditional prohibition.
- decision rule: If an instruction uses `must not` or equivalent prohibition, execution must block that action and apply stop/report handling if requested.
- allowed values: `block-action`
- prohibited interpretations: `soft-warning`, `discouraged-only`, `override-without-authority`
- evidence source: refusal text, blocked command logs, or report record

### Entry 5
- term: `should not`
- category: `priority`
- canonical meaning: A discouraged action that requires explicit rationale if performed.
- decision rule: If an instruction uses `should not`, avoid the action by default; if performed, include rationale in the final report.
- allowed values: `avoid`, `perform-with-rationale`
- prohibited interpretations: `same-as-must-not`, `free-to-ignore-without-rationale`
- evidence source: final report text

### Entry 6
- term: `success(no-op)`
- category: `report-status`
- canonical meaning: The step succeeds because the target state is already compliant and no change was required.
- decision rule: Report `success(no-op)` only when verification confirms no write/update is needed and the existing state matches the required state.
- allowed values: `success(no-op)`
- prohibited interpretations: `skipped-without-check`, `partial-failure`, `unknown-state`
- evidence source: pre-check result and unchanged-state logs

### Entry 7
- term: `unverified`
- category: `state`
- canonical meaning: A claim, assumption, or condition that was not validated by an accepted evidence source.
- decision rule: Mark uncertain statements as `unverified` before proceeding when required by governing rules.
- allowed values: `unverified`
- prohibited interpretations: `verified-by-default`, `silent-assumption`
- evidence source: response/report text containing explicit `unverified` label

### Entry 8
- term: `irreversible action`
- category: `risk`
- canonical meaning: An action that cannot be reliably undone or can permanently affect shared/external state.
- decision rule: If reversibility is unknown, treat as irreversible and request user confirmation before execution.
- allowed values: `requires-confirmation-before-execution`
- prohibited interpretations: `safe-by-default`, `assume-reversible-without-proof`
- evidence source: risk assessment notes and confirmation prompt logs

### Entry 9
- term: `shared state`
- category: `scope`
- canonical meaning: Data, systems, or resources used by multiple actors/processes where one action can affect others.
- decision rule: Actions affecting shared state require strict rule checks and stop/confirmation handling when ambiguity or conflict exists.
- allowed values: `shared-resource-target`, `non-shared-target`
- prohibited interpretations: `personal-local-only-by-default`, `ignore-cross-impact`
- evidence source: target system metadata, path/repository context, or MCP target details

### Entry 10
- term: `canonical path`
- category: `scope`
- canonical meaning: One normalized real filesystem path with resolved symlinks and no ambiguity.
- decision rule: A write must stop if the target cannot be resolved to exactly one canonical real path.
- allowed values: `single-resolved-real-path`
- prohibited interpretations: `relative-or-ambiguous-path-ok`, `multiple-candidate-paths-ok`
- evidence source: path resolution output (e.g., `realpath`) and write pre-check logs

### Entry 11
- term: `exact match`
- category: `action`
- canonical meaning: Trigger comparison that requires the full input string to equal the defined trigger phrase.
- decision rule: For exact-match workflows, do not start execution on partial, fuzzy, or prefix-only matches.
- allowed values: `full-string-equality`
- prohibited interpretations: `contains-match`, `prefix-match`, `semantic-approximation`
- evidence source: trigger-evaluation logs or command input trace
