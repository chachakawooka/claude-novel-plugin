---
name: novel-ideate
description: Deep concept exploration — generate concept variations, conflict webs, stakes maps, and thematic frameworks before outlining.
---

# /novel-ideate — Deep Idea Generation

You are helping the writer explore their story concept in depth before committing to a structure. This command sits between `/novel-init` and `/novel-outline`. Its purpose is to generate the raw material that makes outlining faster and richer.

## Step 1: Load Context

Read from the Obsidian vault via MCP:
- `Novel State.md` — title, genre, target word count, target chapters
- `Plot/Outline.md` — any existing premise (may be empty)
- `Plot/Concept.md` — any existing concept work (may not exist yet)

## Step 2: Gather the Raw Idea

If no concept exists yet, ask the writer to describe their story idea in a few sentences. Anything is fine — a character, a scene, a feeling, a "what if?" question, a genre mashup. Don't ask for structure; ask for the spark.

If a concept already exists, ask what they want to explore further or change direction on.

## Step 3: Concept Variations

Generate **3 distinct concept variations** — different angles on the same core idea. Each variation should explore a different:
- Protagonist (or protagonist type)
- Central conflict
- Tonal approach (dark/light, intimate/epic, etc.)
- Opening situation

For each variation, provide:
- A one-paragraph pitch
- The core question the story asks
- What makes this version distinct from the others

Present all 3 to the writer. They can pick one, combine elements, or ask for more variations.

## Step 4: Genre Analysis

Based on the selected concept direction, analyze the genre landscape:

### Reader Expectations
- What readers of this genre expect (pacing, tone, resolution type)
- Structural conventions (e.g., romance: meet-cute → obstacles → HEA; thriller: opening hook → escalating danger → climactic confrontation)
- Common chapter lengths and total word count norms

### Trope Mapping
- 5-7 core tropes this story could leverage
- For each: how the story could play it straight, subvert it, or combine it with another trope
- Which tropes are overdone and might feel stale without a twist

### Comparable Titles
- 3-5 published novels with similar concepts
- What each does well that this story could learn from
- What each lacks that this story could improve on

## Step 5: "What If?" Expansion

Generate **10 provocative "what if?" questions** that push the concept deeper. These should challenge assumptions and reveal unexplored possibilities:

- What if the obvious villain is actually right?
- What if the protagonist's strength is actually their weakness?
- What if the central problem can't actually be solved?
- What if the setting itself is the antagonist?
- (etc. — tailored to the specific concept)

Present these to the writer. Discuss which ones resonate. The best stories often come from the "what if?" that makes the writer uncomfortable.

## Step 6: Conflict Web

Map all conflicts in the story across multiple dimensions:

### Primary Conflict
- External: protagonist vs. what?
- Internal: protagonist vs. what within themselves?
- How do external and internal conflicts mirror/amplify each other?

### Secondary Conflicts
For each major character (2-4 additional):
- Their personal conflict (what they want vs. what they need)
- Their relational conflict (how they clash with the protagonist or other characters)
- How their conflict intersects with the primary conflict

### Thematic Conflict
- The central thematic tension (e.g., freedom vs. security, truth vs. mercy)
- How this tension manifests differently through different characters
- How the resolution of the plot also resolves (or deliberately doesn't resolve) the thematic conflict

Save to `Plot/Conflict Web.md`:

```yaml
---
type: conflict-web
---
```

Body: structured by primary, secondary (per character), and thematic conflicts. Use `[[wiki-links]]` to character notes if they exist.

## Step 7: Stakes Escalation Map

Design how stakes grow across the story's arc:

### Act 1 Stakes
- What can the protagonist lose at this point?
- Why should the reader care? (personal connection, sympathy, curiosity)
- What's the cost of failure at this stage?

### Act 2 Stakes (escalating)
- How do the stakes expand from personal → interpersonal → larger?
- What new things become at risk as the story progresses?
- Where is the midpoint shift that changes what the protagonist is fighting for?
- What is the "all is lost" moment and why is it devastating?

### Act 3 Stakes
- What is at stake in the climax? (should be the highest stakes of the story)
- Is there something the protagonist must sacrifice to win?
- How do the stakes connect back to the internal conflict?

Save to `Plot/Stakes Map.md`:

```yaml
---
type: stakes-map
---
```

Body: act-by-act stakes with escalation rationale.

## Step 8: Thematic Deep-Dive

Go beyond a single thematic question:

### Central Theme
- The core thematic question (e.g., "Can love survive betrayal?")
- The **counter-theme** — the opposing argument the story must honestly present
- The story's eventual stance (or deliberate ambiguity)

### Thematic Manifestation
- How the theme shows up in **plot** (what events embody the theme?)
- How the theme shows up in **character** (which characters represent which side of the thematic question?)
- How the theme shows up in **world** (how does the setting reflect or challenge the theme?)

### Character Thematic Questions
For each major character, a personal thematic question:
- Protagonist: "Can [character] learn to [growth] before [consequence]?"
- Antagonist: "What happens when [belief] is taken to its logical extreme?"
- Supporting: How do they illuminate a different facet of the theme?

Save the thematic framework to `Plot/Concept.md` alongside the selected concept variation.

## Step 9: Save to Vault

Create or update the following files via MCP:

### `Plot/Concept.md`
```yaml
---
type: concept
variation: {selected variation number or "combined"}
genre-analysis-complete: true
thematic-framework-complete: true
---
```

Body sections:
- **Selected Concept** — The refined concept pitch
- **Core Question** — What the story is really asking
- **Genre Expectations** — Key conventions to honor and subvert
- **Comparable Titles** — Reference points
- **Key "What If?" Insights** — The most resonant explorations
- **Thematic Framework** — Central theme, counter-theme, character themes

### `Plot/Conflict Web.md`
(as described in Step 6)

### `Plot/Stakes Map.md`
(as described in Step 7)

## Step 10: Update Novel State

Update `Novel State.md`:
- Ensure `phase` is `ideation` (it should already be if `/novel-init` was run)

Tell the writer:
- Summary of what was generated
- The strongest elements of their concept
- Suggest next steps: `/novel-outline` to build the structure from this foundation, or continue exploring with another `/novel-ideate` session
