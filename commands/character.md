---
name: novel:character
description: Create or edit character notes with full profiles, voice guides, and relationship maps.
---

# /novel:character — Character Development

You are helping the writer create or edit character notes in their Obsidian vault. Every character gets one markdown file in `Characters/` with structured frontmatter and detailed sections.

## Step 1: Load Context

Read from the Obsidian vault via MCP:
- `Novel State.md` — genre, POV style
- All existing files in `Characters/` — to understand existing characters and relationships
- `Plot/Outline.md` and `Plot/Beat Sheet.md` — to understand the story needs

## Step 2: Determine Action

Ask the writer what they want to do:
- **Create a new character** — build from scratch or from a brief description
- **Edit an existing character** — update or expand a specific character's note
- **Review characters** — show a summary of all characters and identify gaps

## Step 3: Character Creation

If creating a new character, ask the writer for at minimum:
- Name (and any aliases)
- Role (protagonist, antagonist, supporting, minor)
- A brief description or concept

Then collaboratively develop the full profile. Generate suggestions but always let the writer approve or modify.

### Frontmatter

```yaml
---
type: character
role: {protagonist | antagonist | supporting | minor}
age: {age}
gender: {gender}
first-appearance: {chapter number}
status: alive
aliases: [{list of nicknames or titles}]
---
```

### Required Body Sections

**Physical Description** — Distinctive features, build, mannerisms, how they carry themselves. Focus on details that reveal character, not just appearance cataloging.

**Personality**
- Core traits (3-5 defining characteristics)
- Fatal flaw (the trait that creates their problems)
- Strength (the trait that will save them)
- Fears (what they avoid, what keeps them up at night)
- Desires (surface want vs. deep need — these should be in tension)

**Voice** — THIS SECTION IS CRITICAL. It must be filled out before the character appears in any drafted chapter. Include:
- Vocabulary level (simple/educated/archaic/technical/etc.)
- Speech patterns (short sentences? Long rambling? Questions? Commands?)
- Verbal tics (repeated words, phrases, speech habits)
- Sample dialogue (3-5 lines showing how this character actually talks)

**Backstory** — Key events that shaped who they are. Focus on what's relevant to the story.

**Arc**
- Starting state (who they are at the beginning)
- Growth direction (what they're learning/becoming)
- Ending state (who they are at the end)

**Relationships** — Use `[[wiki-links]]` to link to other character notes. Describe the nature of each relationship, the dynamic, and how it evolves.

**Knowledge State** — What the character knows and when they learned it. This section is updated as chapters are drafted and is critical for the Stage 5 continuity critics. Format:

```markdown
## Knowledge State
- Chapter 1: Knows about X, believes Y
- Chapter 3: Learns Z from [[Character B]]
- Chapter 7: Discovers that Y was false
```

## Step 4: Voice Verification

Before saving, verify the voice section is detailed enough by generating 2-3 sample dialogue lines in different emotional states (calm, angry, afraid) and asking the writer if they ring true.

## Step 5: Save and Cross-Reference

- Save the character note to `Characters/{Name}.md` via MCP
- Update any referenced characters' Relationships sections to include a backlink
- If the character appears in the beat sheet, verify the `first-appearance` chapter number matches
