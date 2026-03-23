---
name: novel-init
description: Initialize an Obsidian vault with the Novel Studio folder structure, templates, and Novel State dashboard.
---

# /novel-init — Initialize Novel Vault

You are setting up a new Obsidian vault for novel writing. Follow these steps exactly.

## Step 1: Gather Information

Ask the writer for:
1. **Title** — Working title for the novel
2. **Genre** — e.g., fantasy, sci-fi, literary fiction, thriller, romance, horror
3. **Target word count** — Total target (default: 80,000)
4. **Target chapter count** — How many chapters (default: 25)
5. **POV style** — first-person, third-limited, third-omniscient, multiple-POV
6. **Tense** — past or present
7. **Vault path** — Where the Obsidian vault lives on disk (or use `$OBSIDIAN_VAULT_PATH`)

Wait for the writer to answer before proceeding.

## Step 2: Create Folder Structure

Use the Obsidian MCP server to create the following folders and files in the vault:

```
Manuscript/
  Act 1/
  Act 2/
  Act 3/
Characters/
Worldbuilding/
  Locations/
  Magic/
  Factions/
  History/
Plot/
  Outline.md
  Beat Sheet.md
  Timeline.md
  Concept.md
  Conflict Web.md
  Stakes Map.md
Critique/
  Pre-Writing/
Templates/
  Character Template.md
  Location Template.md
  Scene Template.md
  Concept Template.md
  Conflict Web Template.md
  Stakes Map Template.md
  Research Brief Template.md
Research/
Novel State.md
```

Create each folder by creating a placeholder or the actual template/file within it.

## Step 3: Create Templates

### Character Template (`Templates/Character Template.md`)

```yaml
---
type: character
role:
age:
gender:
first-appearance:
status: alive
aliases: []
---
```

Body sections:
```markdown
## Physical Description


## Personality
- **Core traits**:
- **Fatal flaw**:
- **Strength**:
- **Fears**:
- **Desires**:

## Voice
- **Vocabulary level**:
- **Speech patterns**:
- **Verbal tics**:
- **Sample dialogue**:

## Backstory


## Arc
- **Starting state**:
- **Growth direction**:
- **Ending state**:

## Relationships


## Knowledge State
```

### Location Template (`Templates/Location Template.md`)

```yaml
---
type: location
region:
first-appearance:
climate:
significance:
---
```

Body sections:
```markdown
## Description


## Sensory Details
- **Visual**:
- **Sounds**:
- **Smells**:
- **Atmosphere**:

## History


## Notable Features
```

### Scene Template (`Templates/Scene Template.md`)

```yaml
---
type: scene
chapter:
act:
pov:
characters: []
location:
status: draft
wordcount: 0
plot-threads: []
emotional-beat:
---
```

### Concept Template (`Templates/Concept Template.md`)

```yaml
---
type: concept
variation:
genre-analysis-complete: false
thematic-framework-complete: false
---
```

Body sections:
```markdown
## Selected Concept


## Core Question


## Genre Expectations


## Comparable Titles


## Key "What If?" Insights


## Thematic Framework
- **Central theme**:
- **Counter-theme**:
- **Protagonist thematic question**:
- **Antagonist thematic question**:
```

### Conflict Web Template (`Templates/Conflict Web Template.md`)

```yaml
---
type: conflict-web
---
```

Body sections:
```markdown
## Primary Conflict
### External

### Internal

### Mirror (How external and internal amplify each other)

## Secondary Conflicts

## Thematic Conflict
```

### Stakes Map Template (`Templates/Stakes Map Template.md`)

```yaml
---
type: stakes-map
---
```

Body sections:
```markdown
## Act 1 Stakes
- **What can be lost**:
- **Why the reader cares**:
- **Cost of failure**:

## Act 2 Stakes
- **Escalation from personal → interpersonal → larger**:
- **Midpoint shift**:
- **All-is-lost moment**:

## Act 3 Stakes
- **Climax stakes**:
- **Required sacrifice**:
- **Connection to internal conflict**:
```

### Research Brief Template (`Templates/Research Brief Template.md`)

```yaml
---
type: research-brief
category:
relevance: []
priority:
chapters: []
---
```

Body sections:
```markdown
## Overview


## Key Facts


## Common Pitfalls


## Specific Details for Prose


## Terminology Guide


## Story Integration Notes
```

## Step 4: Create Novel State.md

Create `Novel State.md` at the vault root with the writer's answers:

```yaml
---
type: novel-state
title: "{title}"
genre: {genre}
pov: {pov_style}
tense: {tense}
target-words: {target_words}
target-chapters: {target_chapters}
phase: ideation
created: {today's date YYYY-MM-DD}
---
```

Body with Dataview queries:

````markdown
# {title}

## Dashboard

### Chapters
```dataview
TABLE status, wordcount, pov, emotional-beat
FROM "Manuscript"
WHERE type = "scene"
SORT chapter ASC
```

### Characters
```dataview
TABLE role, age, status, first-appearance
FROM "Characters"
WHERE type = "character"
SORT role ASC
```

### Plot Threads
```dataview
TABLE status, importance, introduced, resolved
FROM "Plot"
WHERE type = "plot-thread"
SORT importance ASC
```

### Research Briefs
```dataview
TABLE category, priority, relevance
FROM "Research"
WHERE type = "research-brief"
SORT priority ASC
```

### Critique Pipeline
```dataview
TABLE stages-completed, status
FROM "Critique"
SORT file.name ASC
```
````

## Step 5: Create Initial Plot and Research Files

Create empty starter files:

**Plot/Concept.md:**
```yaml
---
type: concept
variation:
genre-analysis-complete: false
thematic-framework-complete: false
---
```
```markdown
# Concept

(To be filled by /novel-ideate)
```

**Plot/Conflict Web.md:**
```yaml
---
type: conflict-web
---
```
```markdown
# Conflict Web

(To be filled by /novel-ideate)
```

**Plot/Stakes Map.md:**
```yaml
---
type: stakes-map
---
```
```markdown
# Stakes Map

(To be filled by /novel-ideate)
```

**Plot/Outline.md:**
```yaml
---
type: outline
---
```
```markdown
# Outline

## Premise


## Logline


## Theme


## Act Structure

### Act 1 — Setup


### Act 2 — Confrontation


### Act 3 — Resolution
```

**Plot/Beat Sheet.md:**
```yaml
---
type: beat-sheet
---
```
```markdown
# Beat Sheet

## Chapter-by-Chapter Beats

(To be filled by /novel-outline)
```

**Plot/Timeline.md:**
```yaml
---
type: timeline
---
```
```markdown
# Timeline

(Events will be added as chapters are drafted)
```

## Step 6: Confirm

Tell the writer:
- The vault is set up and ready
- Show them the folder structure that was created
- Suggest next steps: `/novel-ideate` to explore the concept in depth, then `/novel-outline` to plan the structure, `/novel-character` to create characters, `/novel-world` to build the world
- Remind them they can edit any file directly in Obsidian at any time
