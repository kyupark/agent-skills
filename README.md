# agent-skills

A collection of AI agent skills for Clawdbot, Claude Code, Codex, and other LLM-based coding assistants.

## Generic Skills

These skills work with any AI coding agent:

<!-- SKILLS_START -->
- `elegant-reports`: Generate beautifully designed PDF reports with Nordic/Scandinavian aesthetic. Uses Nutrient DWS A...
- `humanizer`: Remove signs of AI-generated writing from text. Use when editing or reviewing text to make it sou...
- `jira`: Manage Jira issues, boards, sprints, and projects via the jira-cli. Search, create, update, and t...
- `munger-observer`: Daily wisdom review applying Charlie Munger's mental models to your work and thinking. Use when a...
- `nudocs`: Upload, edit, and export documents via Nudocs.ai. Use when creating shareable document links for ...
- `planner`: Create structured plans for multi-task projects that can be executed by the task-orchestrator ski...
- `remotion-best-practices`: Best practices for Remotion - Video creation in React
- `senior-engineering`: Engineering principles for building software like a senior engineer. Load when tackling non-trivi...
- `frontend-design`: Expert frontend design guidelines for creating beautiful, modern UIs. Use when building landing p...
- `sysadmin-toolbox`: Tool discovery and shell one-liner reference for sysadmin, DevOps, and security tasks. AUTO-CONSU...
- `task-orchestrator`: Autonomous multi-agent task orchestration with dependency analysis, parallel tmux/Codex execution...
- `web-design-guidelines`: Review UI code for Web Interface Guidelines compliance. Use when asked to review my UI, check acc...
<!-- SKILLS_END -->

## Clawdbot-Specific Skills

These skills are designed specifically for [Clawdbot](https://github.com/clawdbot/clawdbot):

<!-- CLAWDBOT_SKILLS_START -->
- `auto-updater`: Automatically update Clawdbot and all installed skills once daily. Runs via cron, checks for upda...
- `clawdbot-release-check`: Check for new clawdbot releases and notify once per new version.
- `clawddocs`: Clawdbot documentation expert with decision tree navigation, search scripts, doc fetching, versio...
- `skill-sync`: Sync Clawdbot skills between local installation and the shared skill repository. Use when asked t...
- `todo-tracker`: Persistent TODO scratch pad for tracking tasks across sessions. Use when user says add to TODO, w...
<!-- CLAWDBOT_SKILLS_END -->

## Installation

### With Clawdbot

Add skills to your Clawdbot config:

```yaml
skills:
  paths:
    - /path/to/jdrhyne-skills/skills/skill-name
```

### With Claude Code / Codex

Copy the skill folder to your project or user instructions directory:

```bash
# Copy a specific skill
cp -r skills/elegant-reports ~/.codex/skills/

# Or symlink
ln -s /path/to/jdrhyne-skills/skills/elegant-reports ~/.codex/skills/
```

### Manual

Each skill is self-contained in its folder. Copy the SKILL.md (and any supporting files) to your agent's context.

## Skill Structure

Each skill follows this structure:

```
skills/
└── my-skill/
    ├── SKILL.md          # Main skill definition (required)
    ├── scripts/          # Helper scripts (optional)
    ├── templates/        # Templates/assets (optional)
    └── README.md         # Additional docs (optional)
```

### SKILL.md Format

```markdown
---
name: my-skill
description: Brief description of what the skill does
---

# Skill Name

Detailed instructions for the AI agent...
```

## Creating a New Skill

1. Create a folder in `/skills`:
   ```bash
   mkdir skills/my-new-skill
   ```

2. Create `SKILL.md` with frontmatter:
   ```markdown
   ---
   name: my-new-skill
   description: What this skill does
   ---
   
   # My New Skill
   
   Instructions...
   ```

3. Run the README updater:
   ```bash
   ./scripts/update-readme.sh
   ```

4. Commit and push:
   ```bash
   git add skills/my-new-skill
   git commit -m "Add my-new-skill"
   git push
   ```

## Scripts

- `scripts/update-readme.sh` — Scans `/skills` and updates this README
- `scripts/validate-skills.sh` — Validates all skills have proper SKILL.md

## License

MIT — Use these skills however you like.

## Author

Jonathan Rhyne ([@jdrhyne](https://github.com/jdrhyne))
