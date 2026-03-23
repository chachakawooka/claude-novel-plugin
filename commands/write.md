---
name: novel-write
description: Draft a chapter using multi-agent collaboration, grounded in vault context (characters, world, plot).
---

# /novel-write — Chapter Drafting

You are orchestrating the drafting of a novel chapter. This uses multi-agent collaboration to produce prose grounded in the writer's Obsidian vault.

## Step 1: Determine Which Chapter

Ask the writer which chapter to draft, or determine the next unwritten chapter from the beat sheet.

## Step 2: Load Context from Vault

Read ALL of the following from the Obsidian vault via MCP before writing any prose:

1. **Beat Sheet entry** — Read `Plot/Beat Sheet.md` and extract this chapter's entry (scene goals, conflicts, emotional arc, plot threads to advance)
2. **POV character** — Read the full character note from `Characters/` for whoever has POV. Pay special attention to the **Voice** section (vocabulary, speech patterns, verbal tics, sample dialogue)
3. **Scene characters** — Read notes for ALL characters present in the scene
4. **Location** — Read the location note from `Worldbuilding/Locations/` for the scene's setting
5. **Previous chapter ending** — Read the last 200-300 words of the previous chapter from `Manuscript/` for transition flow
6. **Active plot threads** — Read all plot thread notes from `Plot/` that have `status: active`
7. **World-building rules** — Read any relevant magic system, faction, or history notes that apply to this chapter

If any critical context is missing (e.g., no voice profile for the POV character), stop and tell the writer. Suggest running `/novel-character` first.

## Step 3: Present Approach

Before generating prose, present to the writer:
- 2-3 **opening paragraph variations** (different hooks/tones)
- The intended **scene structure** (how many scenes, what each covers)
- Any **creative decisions** that need input (e.g., "Should this reveal happen on-page or off?")

Wait for the writer to approve or redirect before proceeding.

## Step 4: Generate Prose

Write at the **scene level** — each scene should be 800-1,500 words.

Key principles:
- **Match the POV character's voice** — vocabulary, sentence patterns, internal monologue style must match the Voice section of their character note
- **Ground in sensory details** — use the location's Sensory Details section
- **Advance plot threads** — every scene must move at least one thread forward
- **Show, don't tell** — dramatize emotions through action and dialogue
- **Dialogue matches voice profiles** — each character should sound distinct per their Voice section
- **Maintain continuity** — respect character Knowledge States, world rules, timeline

Compose the full chapter from its constituent scenes.

## Step 5: Parallel Chapter Drafting

When the writer wants to draft multiple independent chapters simultaneously:
- Spawn a drafter subagent per chapter using the Agent tool
- Each agent gets its own context loaded from the vault
- The main session coordinates and reviews

Use subagent_type "general-purpose" for each drafter. Provide each agent with:
- The specific chapter's beat sheet entry
- All relevant character, location, and plot context
- Instructions to write scene-by-scene at 800-1,500 words per scene
- The output path in `Manuscript/Act N/Chapter NN.md`

Maximum 10 concurrent drafter agents.

## Step 6: Save to Vault

After the writer approves a chapter (or each scene):

1. **Save the chapter** to `Manuscript/Act {N}/Chapter {NN}.md` via MCP with full frontmatter:

```yaml
---
type: scene
chapter: {number}
act: {act number}
pov: "[[{POV Character}]]"
characters: ["[[{Character A}]]", "[[{Character B}]]"]
location: "[[{Location}]]"
status: draft
wordcount: {actual word count}
plot-threads: ["{Thread A}", "{Thread B}"]
emotional-beat: {emotional arc description}
---
```

2. **Update character Knowledge States** — In each character's note, add what they learned this chapter under the Knowledge State section.

3. **Update plot thread notes** — For each advanced thread, add the chapter to its key beats list.

4. **Update Timeline** — Add new events to `Plot/Timeline.md` with chapter reference and in-world time.

## Step 7: Transition

After saving, tell the writer:
- Word count for the chapter
- Which plot threads were advanced
- Suggest next steps: draft the next chapter, or run `/novel-critique` on this one
