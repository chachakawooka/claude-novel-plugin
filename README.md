# Novel Studio Marketplace

A Claude Code plugin marketplace for creative writing and novel development.

## Installation

Add this marketplace to Claude Code:

```shell
/plugin marketplace add chachakawooka/claude-novel-plugin
```

Then install the plugin:

```shell
/plugin install novel-studio@novel-studio-marketplace
```

## Available Plugins

### novel-studio

A comprehensive plugin for solo novelists. Integrates with Obsidian vaults for deep ideation, research, world-building, multi-agent chapter drafting, a 3-stage pre-writing validation pipeline, and a 5-stage critique pipeline with critics, judges, and implementers.

**Setup:**

1. Install the plugin (see above)
2. Set your Obsidian vault path:
   ```bash
   export OBSIDIAN_VAULT_PATH="/path/to/your/vault"
   ```
3. Run `/novel-init` to create the vault structure

**Requirements:**

- An Obsidian vault (or a directory where one will be created)
- Node.js (for the Obsidian MCP server via `npx`)

**Commands:**

| Command | Description |
|---------|-------------|
| `/novel-init` | Initialize vault with folder structure, templates, and dashboard |
| `/novel-ideate` | Deep concept exploration — variations, conflict web, stakes map, thematic framework |
| `/novel-outline` | Generate story structure — premise, act structure, chapter beats, plot threads |
| `/novel-character` | Create or edit character notes with voice profiles and relationship maps |
| `/novel-world` | Create or edit world-building — locations, magic, factions, history |
| `/novel-research` | Generate structured research briefs for accuracy and genre conventions |
| `/novel-validate` | Run the 3-stage pre-writing QA pipeline before drafting |
| `/novel-write` | Draft chapters with multi-agent collaboration, grounded in vault context |
| `/novel-critique` | Run the 5-stage critique pipeline on a chapter |
| `/novel-status` | View progress dashboard — chapters, word counts, plot threads, critique status |

**The 5-Stage Critique Pipeline:**

| Stage | Focus | Scope |
|-------|-------|-------|
| 1 | Plot & Structure | Can restructure scenes |
| 2 | Character Development | Scene-level; structure locked |
| 3 | Prose Quality | Paragraph-level; characters locked |
| 4 | Dialogue | Line-level; prose locked |
| 5 | Continuity | Read-only audit |

Each stage runs: **3 Critics** (parallel) → **3 Judges** (parallel vote) → **3 Implementers** (parallel, except Stage 5).

**The 3-Stage Pre-Writing Validation Pipeline:**

| Stage | Focus | Validators |
|-------|-------|-----------|
| A | Narrative Architecture | Plot Hole Detector, Stakes & Tension Auditor, Pacing Forecaster |
| B | Character Readiness | Arc Completeness, Voice Profile Auditor, Relationship Web |
| C | World Consistency | Rule System Auditor, Timeline Feasibility, Setting Coverage |

## Contributing

To add a new plugin to this marketplace:

1. Create a directory under `plugins/` with a `.claude-plugin/plugin.json` manifest
2. Add the plugin entry to `.claude-plugin/marketplace.json`
3. Submit a pull request

## Directory Structure

```
.claude-plugin/
  marketplace.json          # Marketplace catalog
plugins/
  novel-studio/             # Novel writing plugin
    .claude-plugin/
      plugin.json           # Plugin manifest
    agents/                 # Critic, judge, validator, and implementer agents
    commands/               # Slash commands (/novel-init, /novel-write, etc.)
    hooks/                  # Session lifecycle hooks
    skills/                 # Auto-activating skills
    settings.json           # Plugin configuration
```
