---
name: skill-check-rule
description: Agents or reviewers who audit skill documentation repositories for consistency must apply this rule to validate structure, references, and cross-document compatibility.
---

# Skill Check Rule

# Must

## Scope
- You must apply this document when checking consistency across skill rule documents and related governance documents in the same repository.
- You must run checks using file-system evidence, document content evidence, and executable script evidence when scripts are part of the checked scope.
- For this document, "governed root scope" means `D:/work/nowonbun-harness/codex-skills`.
- For this document, "same scope" means directives that apply to the same document set, execution context, and role in the governed root scope.

## Out of Scope
- You must not classify backup notes or temporary memos as active skill rule documents.
- You must not treat example paths or placeholder paths as operational paths.

## Source of Truth
- This document governs consistency-check procedure, file-role classification, and pass/fail criteria for skill-document repositories; it does not govern skill authoring format, governance tier definitions, or history-record obligations.
- `global_instructions` is the single source of truth for global principles and safety boundaries; consult it when a check finding touches a system-level safety boundary, not for skill-repository structure questions.
- `AGENTS` is the single source of truth for workspace execution triggers and operational workflows; consult it when determining what triggers a check run, not for how to evaluate check results.
- `../skill-management_constitution-rule/SKILL.md` is the single source of truth for constitution-layer priority and conflict handling; consult it when a conflict involves constitution-layer precedence, not for skill-document format disputes.
- `../skill-management_skill-create-rule/SKILL.md` is the single source of truth for skill-document authoring format and per-skill history path pattern; consult it when evaluating whether a skill document's structure is compliant, not for governance tier or history-obligation decisions.
- `../skill-management_skill-governance-rule/SKILL.md` is the single source of truth for governance-tier definitions and governance controls; consult it when determining whether a skill's governance tier is correctly assigned, not for format or history-record questions.
- `../skill-management_skill-modify-history/SKILL.md` is the single source of truth for history-recording obligations and day-based history criteria; consult it when determining whether a required history file is missing, not for skill-document format questions.

## File and Role Validation
- If a referenced file does not exist at the resolved path, you must record an error.
- You must classify each checked markdown document as active skill rule, backup/history, or explanatory document using path, frontmatter, and repository guidance files.
- If a document is classified as non-operational, you must not describe it as an active rule source.
- You must confirm that active-skill lists include only operational skill source documents in the governed root scope.

## Format and Identity Validation
- If a document is an active skill rule, you must verify YAML frontmatter existence and required keys.
- You must verify that file name, frontmatter `name`, and declared role are consistent.
- You must verify that document descriptions and workflow references match actual files or scripts.

## Path and Encoding Validation
- You must verify that every operational reference path is resolvable in the current repository structure.
- If a path is an example or template path, you must label it as non-operational in the report.
- If Korean text contains repeated replacement characters such as `U+FFFD` or abnormal `?` substitutions from encoding corruption, you must record an encoding error.

## Rule-Set Consistency Validation
- You must verify that directives across checked documents are simultaneously satisfiable in the same scope.
- If two directives in the same scope require contradictory mandatory language, you must record a conflict error.
- If two directives create a mandatory procedural loop with no executable entry point, you must record a cyclic-dependency error.
- If a directive uses ambiguous language without explicit scope, priority, or exception criteria, you must record an ambiguity error.
- You must verify that overlapping rules declare a clear precedence source to preserve single-source-of-truth behavior.

## History and Traceability Validation
- If a checked rule document was revised, you must verify that a corresponding history record exists under the history path policy defined in `../skill-management_skill-create-rule/SKILL.md` and `../skill-management_skill-modify-history/SKILL.md`.
- If required history evidence is missing, you must record a traceability error.
- You must treat unverifiable items as `unverified`, not as pass.
- You must use history records as the revision-tracking source, because frontmatter metadata is constrained by `../skill-management_skill-create-rule/SKILL.md`.

## Reporting Requirements
- You must report findings with separated sections for verified facts, detected errors, ambiguity findings, cyclic-dependency findings, and unverified items.
- You must include severity ordering in the report.
- You must assign highest severity to execution-blocking conflicts such as mandatory contradiction and non-startable procedural cycles.
- You must assign next severity to missing operational references and broken paths in active documents.
- You must assign next severity to format defects, encoding corruption, single-source-of-truth violations, and missing history evidence.

# Must NOT

## Prohibited Evaluation Behavior
- You must not pass an item without evidence.
- You must not merge `error` and `unverified` states into one status.
- You must not report ambiguity findings without quoting the ambiguous expression and missing decision criteria.
- You must not omit failure reasons when reporting a failed check.

## Prohibited Rule Interpretation
- You must not interpret optional examples as mandatory operational instructions.
- You must not treat lower-priority documents as precedence sources when a higher-priority source already defines the rule.
- You must not label a document pair as compatible when both cannot be satisfied together under the same conditions.

# Flow

## Consistency Check Procedure
1. Build the target document list from active skill-rule and governance-rule markdown files under the governed root scope, and resolve canonical paths.
2. Validate file existence and classify each document role.
3. Validate frontmatter, identity consistency, and reference-to-implementation consistency for active rule documents.
4. Validate operational paths and separate template/example paths.
5. Validate encoding integrity for Korean text where applicable.
6. Validate directive compatibility, precedence declarations, ambiguity criteria, and cyclic dependencies across documents.
7. Validate required history evidence for revised rule documents.
8. Produce the result report with separated status sections and severity order.

# Definition of Done

## Verification
- Every checked item has evidence from files, logs, or executable outputs.
- Missing references are recorded as `error`.
- Non-operational documents are not classified as active rule sources.
- Active rule documents pass frontmatter and identity consistency checks.
- Operational paths are resolvable, and example/template paths are explicitly labeled as non-operational.
- Encoding corruption signals are evaluated and reported when present.
- Cross-document mandatory contradictions and cyclic dependencies are detected and reported when present.
- Ambiguous directives without criteria are detected and reported when present.
- Required history evidence for revised rule documents is validated and reported.
- The final report contains separated sections for facts, errors, ambiguity, cyclic dependencies, unverified items, and severity order.
