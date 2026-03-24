---
name: novel-validate
description: Run the 3-stage pre-writing QA pipeline — validators and judges assess narrative architecture, character readiness, and world consistency before drafting begins.
---

# /novel-validate — Pre-Writing QA Pipeline

You are orchestrating the pre-writing validation pipeline. This runs BEFORE any chapter drafting and ensures the outline, characters, and world-building are consistent, complete, and ready to support prose.

## Overview

```
STAGE A: Narrative Architecture → STAGE B: Character Readiness → STAGE C: World Consistency
```

Each stage: 3 Validators (parallel) → 3 Judges (parallel, then vote)

Unlike the post-writing critique, there is no implementation phase — findings produce a readiness report for the writer to address manually using `/novel-outline`, `/novel-character`, `/novel-world`, or `/novel-research`.

## Step 1: Setup

1. Read the FULL vault context via MCP:
   - `Novel State.md`
   - `Plot/Outline.md`, `Plot/Beat Sheet.md`, `Plot/Concept.md`, `Plot/Conflict Web.md`, `Plot/Stakes Map.md`
   - All plot thread notes in `Plot/`
   - All character notes in `Characters/`
   - All world-building notes in `Worldbuilding/` (Locations, Magic, Factions, History)
   - All research briefs in `Research/`
   - `Plot/Timeline.md`

2. Verify minimum requirements before starting:
   - Beat Sheet exists with at least one chapter entry
   - At least one character note exists
   - If any of these are missing, tell the writer what's needed and suggest the appropriate command

3. Create the validation output structure via MCP:
   ```
   Critique/Pre-Writing/
     Stage-A/critics/
     Stage-A/judges/
     Stage-B/critics/
     Stage-B/judges/
     Stage-C/critics/
     Stage-C/judges/
   ```

4. Initialize the validation ledger:
   ```json
   {
     "stages_completed": 0,
     "total_findings": 0,
     "critical_count": 0,
     "major_count": 0,
     "minor_count": 0,
     "approved_findings": [],
     "rejected_findings": []
   }
   ```
   Save to `Critique/Pre-Writing/validation-ledger.json`

## Step 2: Ask Writer Preferences

Before starting, ask:
- Run all 3 stages automatically, or pause between stages for review?
- Any specific concerns to focus on?
- Any areas to skip? (not recommended for first validation)

## Step 3: Run Stages Sequentially

For each stage (A through C), unless the writer skipped it:

### WAVE 1: Validators (Parallel — up to 3 concurrent agents)

Spawn 3 validator subagents simultaneously using the Agent tool. Each validator gets:
- Its agent definition (from `agents/validators/stage-{a|b|c}-*.md`)
- ALL relevant vault context for its domain
- Instructions to output findings in the standard format

**Stage A Validators:**
- `plot-hole-detector` — Unresolved setups, dead-end threads, logical impossibilities, missing cause-effect
- `stakes-tension-auditor` — Stakes escalation, tension variety, turning points, protagonist risk
- `pacing-forecaster` — Act proportions, chapter purpose, action/reflection balance, subplot weight

**Stage B Validators:**
- `arc-completeness-checker` — Complete arcs for protagonists/antagonists, flaw/desire tension, character agency
- `voice-profile-auditor` — Voice sections exist and are distinct, vocabulary matches backstory, sample dialogue quality
- `relationship-web-validator` — Bidirectional relationships, conflict-generating dynamics, evolution arcs, no isolated characters

**Stage C Validators:**
- `rule-system-auditor` — Specific testable rules, costs/limitations, no plot-convenient exceptions, consistent internal logic
- `timeline-feasibility-checker` — Travel feasibility, parallel plotline consistency, chronological soundness, seasonal consistency
- `setting-coverage-validator` — All beat sheet locations have notes, sensory detail coverage, world supports conflicts

Each validator outputs JSON to `Critique/Pre-Writing/Stage-{A|B|C}/critics/{validator-name}.json`:

```json
{
  "validator": "{validator-name}",
  "stage": "{A|B|C}",
  "findings": [
    {
      "id": "V{A|B|C}-{INITIALS}-{NNN}",
      "severity": "critical | major | minor",
      "location": {
        "file": "{vault file path}",
        "section": "{heading or frontmatter field}",
        "excerpt": "Brief quote showing the issue"
      },
      "issue": "Clear description of the problem",
      "recommendation": "Specific action to fix it",
      "rationale": "Why this matters for the novel",
      "affects": ["list of downstream impacts — which chapters, characters, or systems are affected"]
    }
  ],
  "positive_notes": ["What's working well — REQUIRED, at least 2"]
}
```

Wait for ALL 3 validators to complete before proceeding.

### WAVE 2: Judges (Parallel — 3 concurrent agents)

Spawn 3 judge subagents simultaneously. Each judge reads independently:
- ALL validator findings from this stage
- The relevant vault context
- Their judge persona definition (from `agents/judges/judge-panel.md`)

**Judge personas (same as post-writing critique):**
1. **Literary Editor** — Craft quality lens. Does this issue genuinely weaken the story?
2. **Target Reader** — Reader engagement lens. Would a reader notice or care about this issue?
3. **Devil's Advocate** — Preservation lens. Is this finding actually a problem, or is the validator being too rigid? Defends creative choices that break conventions intentionally.

Judges must NOT see each other's verdicts — they evaluate independently.

Each judge outputs to `Critique/Pre-Writing/Stage-{A|B|C}/judges/{judge-name}.json`:

```json
{
  "judge": "{judge-name}",
  "stage": "{A|B|C}",
  "verdicts": [
    {
      "finding_id": "V{A|B|C}-{ID}",
      "vote": "APPROVE | REJECT | MODIFY",
      "reasoning": "Why this verdict",
      "modified_recommendation": "Only if MODIFY — adjusted recommendation"
    }
  ],
  "overall_assessment": "Brief summary of this stage's readiness",
  "stage_score": {1.0-10.0}
}
```

Wait for ALL 3 judges to complete.

### VOTE SYNTHESIS (Orchestrator does this directly)

For each finding across all validators:
1. Tally votes from all 3 judges
2. **2+ APPROVE** → Finding is validated (real issue)
3. **2+ REJECT** → Finding is dismissed (not a real problem or intentional creative choice)
4. **Split (one of each)** → MODIFY (use the MODIFY recommendation)

Write results:
- `Critique/Pre-Writing/Stage-{A|B|C}/approved-findings.json` — validated findings for this stage
- Update `Critique/Pre-Writing/validation-ledger.json` — append findings, increment counts, increment `stages_completed`

### Present Stage Results (if pausing between stages)

Show the writer:
- Validated findings for this stage, grouped by severity
- Stage score (average of judge scores)
- Key concerns and what to fix

## Step 4: Generate Readiness Report

After all stages complete, generate `Critique/Pre-Writing/readiness-report.md`:

```markdown
# Pre-Writing Readiness Report

## Overall Score
{weighted average: Stage A score × 0.4 + Stage B score × 0.3 + Stage C score × 0.3}

## Readiness Status
{READY | READY WITH WARNINGS | NOT READY}

- READY: No critical findings, 2 or fewer major findings
- READY WITH WARNINGS: No critical findings, 3+ major findings
- NOT READY: 1+ critical findings

## Critical Blockers (Must Fix Before Writing)
{List of critical findings with recommended fix and affected areas}

## Major Issues (Should Fix Before Writing)
{List of major findings with recommended fix}

## Minor Suggestions (Can Address During Writing)
{List of minor findings}

## What's Strong
{Consolidated positive notes from all validators — what's working well}

## Recommended Fix Order
{Ordered list of issues to address, considering dependencies — e.g., fix plot holes before refining character arcs that depend on those plot points}

## Stage Scores
- Stage A (Narrative Architecture): {score}/10
- Stage B (Character Readiness): {score}/10
- Stage C (World Consistency): {score}/10

## Next Steps
{Based on status:
- NOT READY: "Address critical blockers, then run `/novel-validate` again"
- READY WITH WARNINGS: "Consider addressing major issues. You can proceed with `/novel-write` but some chapters may need revision"
- READY: "Your story foundation is solid. Proceed with `/novel-write`"}
```

Save via MCP.

## Step 5: Update Novel State

Update `Novel State.md`:
- If READY or READY WITH WARNINGS: change `phase` to `validated`
- If NOT READY: keep `phase` as current (don't advance)

## Step 6: Present to Writer

Show the writer:
- The readiness status and overall score
- Critical blockers (if any)
- Top 3-5 most impactful findings
- The recommended fix order
- What's strong about their preparation
- Next steps based on readiness status

## Writer Controls

The writer can:
- **"Skip Stage {A|B|C}"** — Skip a stage
- **"Focus on {area}"** — Ask validators to prioritize specific concerns
- **"Dismiss finding {ID}"** — Override a validated finding (creative choice)
- **"Re-run validation"** — After making fixes, run the full pipeline again. Previous results in `Critique/Pre-Writing/` are archived (renamed with timestamp suffix) before generating fresh results
- **"Proceed anyway"** — Override NOT READY status (the writer has final say)
