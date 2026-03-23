---
name: novel-critique
description: Run the 5-stage critique pipeline on a chapter — critics, judges, and implementers refine the draft.
---

# /novel-critique — 5-Stage Critique Pipeline

You are orchestrating the critique pipeline for a novel chapter. This is the most complex system in the plugin. Follow the orchestration logic exactly.

## Overview

```
STAGE 1: Plot & Structure → STAGE 2: Character → STAGE 3: Prose → STAGE 4: Dialogue → STAGE 5: Continuity (read-only)
```

Each stage: 3 Critics (parallel) → 3 Judges (parallel, then vote) → 3 Implementers (parallel, except Stage 5)

Scope narrows each stage. Earlier stages' changes are LOCKED via the approval ledger.

## Step 1: Setup

Ask the writer which chapter to critique. Then:

1. Read the chapter from `Manuscript/` via MCP
2. Read all relevant context:
   - POV character note (especially Voice section)
   - All characters in the scene
   - Location note
   - Active plot thread notes
   - Beat sheet entry for this chapter
   - World-building rules (magic systems, faction rules, etc.)
3. Create the critique output folder structure via MCP:
   ```
   Critique/Chapter-{NN}/
     Stage-1/critics/
     Stage-1/judges/
     Stage-2/critics/
     Stage-2/judges/
     Stage-3/critics/
     Stage-3/judges/
     Stage-4/critics/
     Stage-4/judges/
     Stage-5/critics/
     Stage-5/judges/
   ```
4. Initialize the approval ledger:
   ```json
   {
     "chapter": {chapter_number},
     "stages_completed": 0,
     "approved_changes": [],
     "locked_scopes": []
   }
   ```
   Save to `Critique/Chapter-{NN}/approval-ledger.json`

## Step 2: Ask Writer Preferences

Before starting, ask:
- Run all 5 stages automatically, or pause between stages for review?
- Skip any stages? (e.g., "Skip dialogue critique")
- Any specific concerns to focus on?

## Step 3: Run Stages Sequentially

For each stage (1 through 5), unless the writer skipped it:

### WAVE 1: Critics (Parallel — up to 3 concurrent agents)

Spawn 3 critic subagents simultaneously using the Agent tool. Each critic gets:
- Its agent definition (from `agents/critics/stage-{N}-*.md`)
- The current chapter text
- Relevant Obsidian vault context (character profiles, world rules, etc.)
- The approval ledger (as a constraint — what's locked and cannot be changed)

**Stage 1 Critics:**
- `pacing-critic` — Tension arc, scene length, hooks, dead/rush spots
- `arc-critic` — Story advancement, setup/payoff, stakes, beat sheet alignment
- `scene-necessity-critic` — Scene value, redundancy, missing scenes, thread advancement

**Stage 2 Critics:**
- `character-arc-critic` — Actions match motivations, earned progression, active characters
- `relationship-critic` — Authentic dynamics, chemistry, power dynamics, evolution
- `voice-critic` — Dialogue matches voice profiles, speaker distinction, verbal tics

**Stage 3 Critics:**
- `craft-critic` — Sentence rhythm, word choice, imagery, paragraph flow, passive voice
- `show-dont-tell-critic` — Emotional dramatization, filter words, adverb clusters, example rewrites
- `sensory-critic` — Sense of place, non-visual senses, mood-setting, action-integrated description

**Stage 4 Critics:**
- `dialogue-authenticity-critic` — Natural phrasing, distinct voices, contractions, responsiveness
- `subtext-critic` — Directness problems, tension between said/meant, silence, unspoken conflict
- `exposition-critic` — "As you know Bob" dialogue, disguised narration, info-dump triggers

**Stage 5 Critics (read-only):**
- `fact-checker-critic` — Physical/object/location contradictions, world-rule violations
- `knowledge-state-critic` — Characters using information they shouldn't have
- `timeline-critic` — Chronological impossibilities, travel time, time-of-day errors

Each critic outputs JSON to `Critique/Chapter-{NN}/Stage-{N}/critics/{critic-name}.json`:

```json
{
  "critic": "{critic-name}",
  "stage": {N},
  "chapter": {chapter_number},
  "findings": [
    {
      "id": "S{N}-{INITIALS}-{NNN}",
      "severity": "critical | major | minor",
      "location": {
        "scene": {scene_number},
        "paragraph_range": [{start}, {end}],
        "excerpt": "Brief quote"
      },
      "issue": "Description of the problem",
      "recommendation": "Specific fix suggestion",
      "rationale": "Why this matters"
    }
  ],
  "positive_notes": ["What's working well — REQUIRED"]
}
```

Wait for ALL 3 critics to complete before proceeding.

### WAVE 2: Judges (Parallel — 3 concurrent agents)

Spawn 3 judge subagents simultaneously. Each judge reads independently:
- The current chapter text
- ALL critic findings from this stage
- The approval ledger
- Their judge persona definition (from `agents/judges/judge-panel.md`)

**Judge personas:**
1. **Literary Editor** — Craft quality lens. Approves clear improvements. Rejects preference-not-quality. Skeptical of changes that flatten distinctive prose.
2. **Target Reader** — Engagement lens. Approves what's more compelling. Rejects technically correct but energy-draining changes. Asks "would I keep reading?"
3. **Devil's Advocate** — Preservation lens. Argues FOR the original text. Approves ONLY if genuinely damaging. Essential counterweight against over-editing.

Judges must NOT see each other's verdicts — they evaluate independently.

Each judge outputs to `Critique/Chapter-{NN}/Stage-{N}/judges/{judge-name}.json`:

```json
{
  "judge": "{judge-name}",
  "stage": {N},
  "chapter": {chapter_number},
  "verdicts": [
    {
      "finding_id": "S{N}-{ID}",
      "vote": "APPROVE | REJECT | MODIFY",
      "reasoning": "Why",
      "modified_recommendation": "Only if MODIFY"
    }
  ],
  "overall_assessment": "Brief summary",
  "stage_score": {1-10}
}
```

Wait for ALL 3 judges to complete.

### VOTE SYNTHESIS (Orchestrator does this directly)

For each finding across all critics:
1. Tally votes from all 3 judges
2. **2+ APPROVE** → Approved
3. **2+ REJECT** → Rejected
4. **Split (one of each)** → MODIFY (use the MODIFY recommendation)

Write results:
- `Critique/Chapter-{NN}/Stage-{N}/approved-changes.json` — changes for this stage
- Update `Critique/Chapter-{NN}/approval-ledger.json` — append approved changes, increment `stages_completed`, add stage scope to `locked_scopes`

Locked scopes per stage:
- Stage 1: `"structure"`, `"scene-order"`
- Stage 2: `"character-arcs"`, `"character-motivations"`
- Stage 3: `"prose-style"`, `"paragraph-structure"`
- Stage 4: `"dialogue-voice"`, `"dialogue-content"`

### WAVE 3: Implementation (Stages 1-4 only, skip for Stage 5)

If there are approved changes, spawn 3 implementer agents:

1. **Rewriter Agent** — Applies approved prose changes. Must:
   - Preserve the writer's voice
   - Preserve locked changes from prior stages
   - Make the minimum change necessary
   - NOT rewrite paragraphs when a sentence fix was approved

2. **Continuity Agent** — Updates surrounding Obsidian notes:
   - Character Knowledge State sections
   - Plot thread notes
   - Timeline.md
   - World-building notes
   - Does NOT change the chapter text

3. **Quality Gate Agent** — Re-reads the rewritten chapter and verifies:
   - Each approved change was implemented correctly
   - No unapproved changes were made (scope creep)
   - No locked prior-stage changes were altered
   - No new issues introduced

Run Rewriter and Continuity in parallel first, then Quality Gate.

**Quality Gate output** to `Critique/Chapter-{NN}/Stage-{N}/implementation-log.json`:

```json
{
  "status": "pass | fail",
  "changes_verified": {count},
  "changes_correct": {count},
  "unapproved_changes": [],
  "locked_changes_violated": [],
  "new_issues_introduced": []
}
```

**If Quality Gate fails:**
- Run ONE more rewriter pass (attempt 2 of 2 max)
- Run Quality Gate again
- If still fails: escalate to the writer with diagnostic notes, do NOT continue automatically

After implementation passes:
- Write updated chapter back to Obsidian via MCP
- Update chapter frontmatter `status` to `stage-{N}`

### Stage 5 Special Handling

Stage 5 has NO implementation phase. After judges vote:
- Judges vote on Stage 5 findings using the same protocol: APPROVE = finding is a real continuity issue, REJECT = false positive, MODIFY = real issue but recommendation needs adjustment
- Record which findings are validated (2+ APPROVE) vs. rejected (2+ REJECT)
- Write validated findings to `Critique/Chapter-{NN}/Stage-5/validated-findings.json`
- These go to the writer for manual review — continuity fixes require creative judgment

## Step 4: Generate Summary

After all stages complete, generate `Critique/Chapter-{NN}/summary.md`:

```markdown
# Critique Summary — Chapter {NN}

## Overview
- Total findings across all stages: {count}
- Approved: {count} | Rejected: {count} | Modified: {count}

## Stage-by-Stage

### Stage 1: Plot & Structure
- Findings: {count}
- Approved: {list}
- Rejected: {list}
- Score: {average of judge scores}

(repeat for each stage)

## Key Changes Made
- {Bulleted list of significant changes}

## Stage 5 Flags (Manual Review Required)
- {List of validated continuity issues for the writer}

## Final Status
Chapter status: approved
```

Save via MCP and update the chapter frontmatter `status` to `approved`.

Update `Novel State.md` phase to `critique` if not already set.

## Step 5: Present to Writer

Show the writer:
- The summary
- Any Stage 5 flags that need manual attention
- The final word count
- Suggest next steps

## Writer Override Controls

The writer can interrupt at any point:
- **"Skip {stage name}"** — Skip that stage entirely
- **"Implement that change anyway"** — Override a judge rejection
- **"Stop after Stage {N}"** — End the pipeline early, mark status as `stage-{N}`
- **"Let me read it"** — Pause between stages for writer review
- **"Re-run Stage {N}"** — Run a stage's critics again on the current text
