# Novel Studio — Claude Code Plugin

A Claude Code plugin for solo novelists. Integrates with Obsidian vaults for world-building, multi-agent chapter drafting, and a 5-stage critique pipeline.

## Setup

1. Install the plugin in Claude Code
2. Set your Obsidian vault path:
   ```bash
   export OBSIDIAN_VAULT_PATH="/path/to/your/vault"
   ```
3. Run `/novel:init` to create the vault structure

## Requirements

- An Obsidian vault (or a directory where one will be created)
- Node.js (for the Obsidian MCP server via `npx`)

## Commands

| Command | Description |
|---------|-------------|
| `/novel:init` | Initialize vault with folder structure, templates, and dashboard |
| `/novel:outline` | Generate story structure — premise, act structure, chapter beats, plot threads |
| `/novel:character` | Create or edit character notes with voice profiles and relationship maps |
| `/novel:world` | Create or edit world-building — locations, magic, factions, history |
| `/novel:write` | Draft chapters with multi-agent collaboration, grounded in vault context |
| `/novel:critique` | Run the 5-stage critique pipeline on a chapter |
| `/novel:status` | View progress dashboard — chapters, word counts, plot threads, critique status |

## The 5-Stage Critique Pipeline

The core differentiator. Each stage has a progressively narrower scope:

| Stage | Focus | Scope | Critics |
|-------|-------|-------|---------|
| 1 | Plot & Structure | Can restructure scenes | Pacing, Arc, Scene Necessity |
| 2 | Character Development | Scene-level; structure locked | Character Arc, Relationship, Voice |
| 3 | Prose Quality | Paragraph-level; characters locked | Craft, Show-Don't-Tell, Sensory |
| 4 | Dialogue | Line-level; prose locked | Authenticity, Subtext, Exposition |
| 5 | Continuity | Read-only audit | Fact Checker, Knowledge State, Timeline |

Each stage runs: **3 Critics** (parallel) → **3 Judges** (parallel vote) → **3 Implementers** (parallel, except Stage 5).

The three judges:
- **Literary Editor** — Evaluates craft quality and literary merit
- **Target Reader** — Evaluates engagement and emotional impact
- **Devil's Advocate** — Argues for preserving the original text; prevents over-editing

## Architecture

- **Obsidian vault** is the single source of truth — all state is markdown + YAML frontmatter
- **Obsidian MCP server** provides read/write access to the vault
- **Subagents** handle parallel drafting and critique (up to 10 concurrent)
- **Approval ledger** enforces scope narrowing across critique stages
- **Hooks** auto-load vault context on session start and preserve state during compaction

## Vault Structure

```
YourVault/
├── Manuscript/          # Chapters organized by act
├── Characters/          # One note per character with voice profiles
├── Worldbuilding/       # Locations, magic, factions, history
├── Plot/                # Outline, beat sheet, timeline, plot threads
├── Critique/            # Critique pipeline output per chapter
├── Templates/           # Note templates for characters, locations, scenes
├── Research/            # Reference material
└── Novel State.md       # Dashboard with Dataview queries
```
