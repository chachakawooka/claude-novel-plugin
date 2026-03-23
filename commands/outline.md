---
name: novel:outline
description: Generate or refine the story outline, act structure, chapter beats, and plot threads.
---

# /novel:outline — Story Structure

You are helping the writer develop their story's structure. All output is saved to the Obsidian vault via MCP.

## Step 1: Load Context

Read from the Obsidian vault via MCP:
- `Novel State.md` — title, genre, target chapters, POV, tense
- `Plot/Outline.md` — any existing premise, logline, theme
- `Plot/Beat Sheet.md` — any existing chapter beats
- All files in `Plot/` — existing plot thread notes
- All files in `Characters/` — existing character notes (for character-driven plotting)

## Step 2: Determine What's Needed

Check what already exists:
- If no premise/logline: start from scratch, ask the writer about their story idea
- If premise exists but no beat sheet: generate the act/chapter structure
- If beat sheet exists: offer to refine, expand, or revise specific sections

## Step 3: Generate Structure

### If Starting Fresh

Ask the writer to describe their story concept in a few sentences. Then generate:

1. **Premise** — One paragraph describing the core conflict
2. **Logline** — One sentence (character + goal + obstacle + stakes)
3. **Theme** — The central thematic question

Save these to `Plot/Outline.md`.

### Act Structure

Generate a 3-act structure:
- **Act 1** (roughly 25% of chapters): Setup, inciting incident, first plot point
- **Act 2** (roughly 50% of chapters): Rising action, midpoint, complications, all-is-lost moment
- **Act 3** (roughly 25% of chapters): Climax, resolution

Save to `Plot/Outline.md` under the Act Structure heading.

### Chapter-by-Chapter Beat Sheet

For each chapter, generate:
- **Chapter number and title**
- **Act**: Which act it falls in
- **POV character**: Who's telling this chapter (for multi-POV)
- **Scene goals**: What must happen in this chapter
- **Conflict**: The central tension
- **Emotional arc**: The emotional trajectory (e.g., hope → despair, tension → release)
- **Plot threads advanced**: Which threads move forward
- **Key revelations**: What the reader or characters learn
- **Chapter hook**: How it ends to keep the reader going

Save to `Plot/Beat Sheet.md`.

### Plot Threads

For each major storyline, create a separate note in `Plot/`:

```yaml
---
type: plot-thread
status: active
introduced: {chapter number}
resolved:
importance: major | minor | subplot
---
```

Body should include:
- Thread description
- Key beats (which chapters advance it)
- Resolution plan
- Characters involved (using `[[wiki-links]]`)

## Step 4: Present to Writer

Show the writer:
- The premise and logline
- A condensed beat sheet (chapter number, title, one-line summary)
- List of plot threads

Ask for feedback. Iterate until the writer is satisfied. Save all changes to the vault.

## Step 5: Update Novel State

After the outline is complete, update `Novel State.md`:
- Change `phase` to `outlining` (or `world-building` if they want to do that next)
