---
name: stock-analysis
description: Engineers analyzing stocks must use this skill when structuring company, financial, chart, and market-flow analysis to report risks clearly.
---

# Stock Analysis Skill

# Must

## Scope
- You must apply this document when analyzing a stock for investment review, trading review, or learning-oriented comparison.
- You must use this document to structure evidence-based stock analysis output, not to promise returns or give certainty.

## Source of Truth
- This document is the single source of truth for stock-analysis structure, evidence presentation, and risk-reporting rules in `./SKILL.md`; it does not govern governance tiers, prompt-routing decisions, or data-fetching tool selection.
- `../action-management_research/SKILL.md` is the single source of truth for fact-versus-interpretation separation when a stock-analysis request expands into broader topic research, because cross-topic evidence separation belongs to `../action-management_research/SKILL.md` rather than this stock-specific structure rule.

## Analysis Setup Rules
- You must define the analysis purpose as investment review, trading review, or learning before presenting conclusions.
- You must define the analysis horizon as short-term, mid-term, or long-term before presenting conclusions.
- You must state uncertainty and analytical limits when evidence is incomplete, delayed, or assumption-based.
- You must reject guaranteed-profit framing when the request asks for certainty or fixed returns.

## Evidence and Method Rules
- You must attach a source or calculation basis when presenting a number, ratio, or indicator.
- You must distinguish technical analysis from fundamental analysis when both appear in one answer.
- You must label unsupported assumptions as `unverified`.
- You must challenge unrealistic user judgment directly and provide a safer alternative or a narrower interpretation.

## Minimum Analysis Coverage Rules
- You must summarize price trend or return trend when trend evidence is available.
- You must describe volume behavior or volatility behavior when market-action evidence is available.
- You must explain market-flow, sector-flow, or relative-strength context when comparative evidence is available.
- You must list major risks as separate items and include macro, industry, or company-specific risk when relevant evidence exists.

## Output Rules
- You must state the conclusion first.
- You must present supporting evidence in bullets or clearly separated sections.
- You must end with a practical next step such as additional data check, risk review, or scenario comparison.

# Must NOT

- You must not present stock analysis as guaranteed profit guidance.
- You must not mix technical-analysis claims and fundamental-analysis claims without labeling the method.
- You must not present a numeric claim without a source or calculation basis.
- You must not hide uncertainty or downside risk behind definitive wording.

# Flow

1. Define the purpose and horizon of the requested stock analysis.
2. Gather evidence and separate technical, fundamental, and contextual signals.
3. Summarize trend, volume or volatility, comparative context, and major risks.
4. State the conclusion first and follow with evidence-backed reasoning.
5. End with a practical next step or missing-data check.

# Definition of Done

## Verification
- The analysis purpose and horizon are defined before conclusions.
- Technical and fundamental analysis are distinguishable when both are used.
- Numeric claims include a source or calculation basis.
- Major risks are listed as separate items when relevant evidence exists.
- The output states the conclusion first and ends with a practical next step.
