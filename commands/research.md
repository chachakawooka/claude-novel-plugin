---
name: novel-research
description: Generate structured research briefs for factual accuracy, genre conventions, and character expertise. Populates the Research/ folder.
---

# /novel-research — Research & Reference

You are helping the writer build a research foundation for their novel. This command analyzes the story's needs and generates structured reference material that will be loaded during chapter drafting.

## Step 1: Verify Prerequisites and Load Context

Before loading context, verify minimum requirements:
- `Plot/Beat Sheet.md` exists with at least one chapter entry
- At least one character note exists in `Characters/`
- If either is missing, tell the writer: "Research briefs need story context to be useful. Please run `/novel-outline` and `/novel-character` first."

Read from the Obsidian vault via MCP:
- `Novel State.md` — genre, title, POV, tense
- `Plot/Outline.md` — premise, theme, act structure
- `Plot/Beat Sheet.md` — chapter-by-chapter beats
- `Plot/Concept.md` — concept, genre analysis, thematic framework
- `Plot/Conflict Web.md` — conflict structure
- All files in `Characters/` — character profiles, backstories, expertise
- All files in `Worldbuilding/` — locations, magic/tech, factions, history
- All existing files in `Research/` — to avoid duplicating existing briefs

## Step 2: Identify Research Needs

Analyze the full story context and categorize research areas:

### Setting Accuracy
- Time period details (if historical or inspired by a specific era)
- Geography and climate of real or analogous locations
- Architecture, infrastructure, technology level
- Flora, fauna, natural environment
- Daily life details (food, clothing, transportation, communication)

### Character Expertise
For each character with a specialized profession, skill, or knowledge domain:
- What they would know and how they would talk about it
- Jargon, tools, daily routines of their profession
- Common misconceptions readers might have
- Details that signal authenticity vs. details that feel like Wikipedia dumps

### Technical Systems
- How the magic/technology/political/economic systems work in practice
- Real-world analogues or inspirations
- Edge cases and failure modes
- How ordinary people interact with these systems (not just experts)

### Cultural Authenticity
- Social norms, taboos, power structures
- Language and communication patterns
- Rituals, customs, celebrations
- Class/caste/social mobility dynamics
- Gender, family, and relationship norms for the setting

### Genre Conventions
- Structural patterns and reader expectations
- Pacing norms (chapter length, act proportions, tension patterns)
- Tone and voice expectations
- Common pitfalls specific to this genre
- What the best books in this genre do that lesser ones don't

### Emotional/Psychological Authenticity
For each character dealing with significant emotional experiences:
- Psychological realism of their reactions (grief, trauma, addiction, love, betrayal, etc.)
- How these experiences manifest in behavior, not just internal monologue
- Physical manifestations of emotional states
- Recovery/processing patterns (what's realistic vs. what's TV shorthand)
- Common writing mistakes in depicting these experiences

## Step 3: Prioritize with Writer

Present the identified research areas to the writer, organized by priority:
- **Critical** — Inaccuracy here would break reader trust (e.g., a medical thriller needs accurate procedures)
- **Important** — Adds significant depth and credibility
- **Nice-to-have** — Enriches but isn't essential

Ask the writer:
- Which areas to research now vs. skip
- Any areas they already know well (mark as "writer expertise — brief only")
- Any areas they want to add that weren't identified

## Step 4: Generate Research Briefs

For each approved research area, generate a structured brief. Use web search when available for current/factual information. Each brief should be practical and prose-focused — not an encyclopedia article, but a writer's reference.

### Brief Structure

```yaml
---
type: research-brief
category: setting | character-expertise | technical | cultural | genre | psychological
relevance: ["[[Character Name]]", "[[Location Name]]", "[[System Name]]"]
priority: critical | important | nice-to-have
chapters: [list of chapter numbers where this is most relevant]
---
```

Body sections:

**Overview** — 2-3 paragraph summary of the topic and why it matters for the story.

**Key Facts** — Bulleted list of essential facts to get right. Focus on what would break immersion if wrong.

**Common Pitfalls** — Mistakes writers commonly make with this topic. Things that make experts cringe. Clichés to avoid.

**Specific Details for Prose** — Concrete sensory details, terminology, and micro-observations that make scenes feel authentic. These are the "show, don't tell" ingredients:
- What it looks like (specific visual details)
- What it sounds like
- What it smells/tastes/feels like
- What people say about it (realistic dialogue snippets)
- What the body does (physical responses, muscle memory, habitual gestures)

**Terminology Guide** — Key terms with brief definitions. Which terms characters would actually use vs. which are too technical or too simplified.

**Story Integration Notes** — How this research connects to specific scenes, conflicts, or character moments in the beat sheet. Specific suggestions for where to weave in details naturally.

## Step 5: Save to Vault

Save each brief to `Research/{Topic Name}.md` via MCP.

Naming convention: descriptive, space-separated (e.g., `Research/Medieval Siege Warfare.md`, `Research/Grief and Loss.md`, `Research/Herbalism and Healing.md`).

## Step 6: Cross-Reference

After creating briefs:
- Add a `## Research References` section to the bottom of relevant character notes, listing applicable briefs with `[[wiki-links]]`
- Add a `## Research References` section to relevant location/system notes
- Do not modify the existing content of these notes — only append the reference section if it doesn't exist

## Step 7: Update Novel State

Update `Novel State.md`:
- Change `phase` to `researching`

Add a Dataview query to Novel State.md if not already present:

```dataview
TABLE category, priority, relevance
FROM "Research"
WHERE type = "research-brief"
SORT priority ASC
```

## Step 8: Present Summary

Tell the writer:
- How many briefs were generated, organized by category
- Which chapters have the most research support
- Any gaps where more research might be needed later
- Suggest next steps: `/novel-validate` to run pre-writing QA, or continue with `/novel-research` for additional areas
