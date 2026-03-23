---
name: novel:world
description: Create or edit world-building notes — locations, magic systems, factions, history, and lore.
---

# /novel:world — World-Building

You are helping the writer develop their novel's world. All notes are saved to the Obsidian vault under `Worldbuilding/` with proper frontmatter and `[[wiki-links]]` for cross-referencing.

## Step 1: Load Context

Read from the Obsidian vault via MCP:
- `Novel State.md` — genre (determines what world-building categories matter)
- All existing files in `Worldbuilding/` — to understand what exists
- `Plot/Outline.md` — to understand what the story needs
- All files in `Characters/` — characters often imply world details

## Step 2: Determine Action

Ask the writer what they want to build:
- **Location** — A place where scenes happen
- **Magic/Technology System** — Rules of supernatural or advanced systems
- **Faction/Organization** — Groups, governments, religions, guilds
- **Historical Event** — Past events that shape the present
- **Cultural Detail** — Customs, languages, social structures
- **Review** — Show all world-building notes and identify gaps

## Step 3: Create or Edit

### Locations (`Worldbuilding/Locations/{Name}.md`)

```yaml
---
type: location
region: {broader area}
first-appearance: {chapter number}
climate: {climate description}
significance: {why this place matters to the story}
---
```

Body sections:
- **Description** — What it looks like, layout, architecture
- **Sensory Details** — Visual, sounds, smells, atmosphere (each sense separately)
- **History** — How this place came to be, what happened here
- **Notable Features** — Landmarks, unique characteristics, hidden aspects

### Magic/Technology (`Worldbuilding/Magic/{Name}.md`)

```yaml
---
type: magic-system
status: active
---
```

Body sections:
- **Overview** — What it is, how it works
- **Rules** — Hard limits, costs, requirements (be specific — these are checked by continuity critics)
- **Practitioners** — Who can use it, training required
- **Cultural Impact** — How it shapes society
- **Story Relevance** — How it affects the plot

### Factions (`Worldbuilding/Factions/{Name}.md`)

```yaml
---
type: faction
status: active | dissolved | secret
influence: major | moderate | minor
---
```

Body sections:
- **Overview** — Purpose, goals, ideology
- **Structure** — Leadership, hierarchy, membership
- **Members** — Link to character notes with `[[Character Name]]`
- **Relationships** — Alliances and rivalries with other factions
- **History** — Origins, key events
- **Story Role** — How they drive or oppose the plot

### History (`Worldbuilding/History/{Event Name}.md`)

```yaml
---
type: historical-event
date: {in-world date or "X years ago"}
significance: {why it matters now}
---
```

Body sections:
- **What Happened** — The event itself
- **Key Figures** — People involved (link to characters if relevant)
- **Consequences** — What changed because of this
- **Legacy** — How it's remembered, what people believe about it vs. what really happened

## Step 4: Cross-Reference

After creating any world-building note:
- Add `[[wiki-links]]` to all related notes (characters, locations, factions, events)
- Update character notes if characters are members of factions or associated with locations
- Verify that any rules established (especially magic systems) are consistent with existing chapters

## Step 5: Consistency Check

Before saving, review the new note against existing world-building for contradictions. Flag any inconsistencies to the writer.
