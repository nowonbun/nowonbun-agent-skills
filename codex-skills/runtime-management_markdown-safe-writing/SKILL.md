---
name: markdown-safe-writing
description: Authors revising Markdown or general text documents must use this skill to choose safe write paths and verify UTF-8 preservation when Windows PowerShell can corrupt Korean text.
---

# Markdown Safe Writing Skill

# Must

## Scope
- You must apply this document when revising Markdown or other text documents that may be written through Windows PowerShell.
- You must apply this document to write-path selection, UTF-8 preservation checks, and corruption diagnosis for text documents.

## Core Conclusion
- Saving a file as UTF-8 alone is not sufficient to prevent Korean-text corruption.
- When long Korean text is passed directly through Windows PowerShell here-strings, pipes, or standard input, the text can be damaged before file write occurs.
- Therefore, you must select a write path that is safe before you start document revision.

## Priority Order
- You must prefer direct `apply_patch` edits first.
- You must use Python `Path(...).write_text(..., encoding='utf-8')` only when Korean payload delivery is kept ASCII-safe.
- You must use PowerShell `Set-Content -Encoding utf8` or `Out-File -Encoding utf8` only when the content path is already safe and mostly ASCII.

## Required Rules
- You must treat `.md`, `.txt`, `.json`, `.yaml`, `.yml`, `.ini`, and `.cfg` files as UTF-8 text documents.
- In Windows PowerShell, you must not pass Korean body text directly through here-strings, pipe input, or standard-input redirection.
- When revising Markdown documents, you must prefer `apply_patch` whenever feasible.
- Even when rewriting an entire document, you must not build long Korean body text directly inside a PowerShell string.
- When a document is already corrupted, you must restore the correct original text instead of finishing with a blind overwrite.
- When `Get-Content` output looks broken, you must distinguish console-display issues from file-content corruption before judging file state.
- When `read_text(encoding='utf-8')` succeeds, you must still check whether Korean text was replaced with `?` before declaring the file healthy.
- When requesting Claude cross-review for text-document changes, you must explicitly ask for UTF-8 integrity and Korean-text preservation checks.

## Source of Truth
- This document governs safe text-document writing paths, UTF-8 preservation checks, and console-versus-file corruption diagnosis in `./SKILL.md`; it does not govern cross-review log structure, skill-history trigger criteria, or general skill-document section layout outside this skill.
- `../skill-management_skill-modify-history/SKILL.md` is the single source of truth for history-record obligations when this writing rule is revised; consult it when deciding whether the revision requires daily or skill-scoped history updates, not for UTF-8 verification or write-path selection decisions.

## Incident Handling
- When a text-corruption incident occurs, you must recover the file from verified correct source text instead of layering partial overwrites on top of corrupted text.
- You must record whether the cause came from storage encoding, input-path handling, or missing verification.
- When the incident required rule-document revision, you must create `history/skill_YYYYMMDD.md` immediately.

## Reporting Items
- You must report the modified file list.
- You must report the write method used.
- You must report UTF-8 verification results.
- You must report Korean-text preservation verification results.
- You must report whether cross-review was run and what range it covered.

# Must NOT
- You must not pass Korean Markdown body text into `python -` through a PowerShell heredoc.
- You must not finish verification after checking only ASCII fragments of a Korean document.
- You must not assume that a document full of `?` is only a console-display issue without file-based verification.
- You must not close a text-corruption incident without updating the relevant rule document and history when rule changes were required.

# Flow
1. Choose the write method in this order: `apply_patch`, ASCII-safe Python write, then limited PowerShell UTF-8 write.
2. After saving, verify bytes, UTF-8 decoding, abnormal `?` repetition, and at least two representative Korean sentences.
3. When cross-review is needed, request integrity review for logical consistency, encoding damage, and Korean-text preservation.

# Definition of Done

## Verification
- The selected write path follows the priority order in `## Priority Order`.
- No prohibited Korean payload path from `## Required Rules` or `# Must NOT` was used.
- Post-save verification checks bytes, UTF-8 decoding, abnormal `?` repetition, and representative Korean-text presence.
- Console-display issues and file-content corruption are evaluated separately.
- Incident handling and reporting items are satisfied when corruption or review events occurred.
