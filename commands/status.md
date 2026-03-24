---
name: novel-status
description: Show a progress dashboard — chapter statuses, word counts, plot threads, critique progress, character coverage.
---

# /novel-status — Progress Dashboard

You are compiling a progress report from the Obsidian vault. Read everything via MCP and present a clean dashboard.

## Step 1: Read Vault State

Read the following from the Obsidian vault via MCP:
- `Novel State.md` — title, genre, phase, target words, target chapters
- `Plot/Concept.md` — whether ideation has been completed
- `Plot/Conflict Web.md` — whether conflict mapping exists
- `Plot/Stakes Map.md` — whether stakes mapping exists
- All files in `Manuscript/` — chapter statuses and word counts
- All files in `Characters/` — character list and roles
- All files in `Plot/` — plot thread statuses
- All files in `Research/` — research brief coverage
- All files in `Critique/` — critique pipeline progress
- `Critique/Pre-Writing/readiness-report.md` — pre-writing validation status

## Step 2: Compile Dashboard

Present the following sections:

### Novel Overview
- Title, genre, phase
- Total words written vs. target
- Chapters completed vs. target
- Overall progress percentage

### Pre-Writing Foundation
- **Ideation**: Whether Concept, Conflict Web, and Stakes Map exist and are populated
- **Research**: Count of research briefs by category (setting, character-expertise, technical, cultural, genre, psychological), which chapters have research support
- **Validation**: Readiness status (READY / READY WITH WARNINGS / NOT READY / not yet run), stage scores, outstanding critical findings

### Chapter Status Table

| Chapter | Act | POV | Status | Words | Plot Threads |
|---------|-----|-----|--------|-------|-------------|
| (from Manuscript frontmatter) |

Status key: `draft` → `stage-1` → `stage-2` → `stage-3` → `stage-4` → `stage-5` → `approved`

### Character Coverage
- List all characters with their roles
- Flag any characters who appear in the beat sheet but don't have a character note yet
- Flag any characters whose Voice section is incomplete (they can't appear in drafts without it)

### Plot Threads

| Thread | Status | Importance | Introduced | Resolved |
|--------|--------|-----------|------------|----------|
| (from Plot/ frontmatter) |

Flag any threads marked `active` that haven't been advanced in 3+ chapters.

### Critique Pipeline

For each chapter that has entered critique:
- Which stage it's at (1-5)
- How many findings per stage
- How many approved vs. rejected
- Current status (in-progress, passed, escalated)

### Recommendations

Based on the dashboard, suggest what the writer should do next:
- If no ideation: suggest `/novel-ideate`
- If no research briefs: suggest `/novel-research`
- If not validated: suggest `/novel-validate`
- If validation has critical findings: list them and suggest fixes
- Chapters ready for critique
- Characters that need Voice sections
- Plot threads that are stalling
- World-building gaps referenced in the beat sheet but not yet created
