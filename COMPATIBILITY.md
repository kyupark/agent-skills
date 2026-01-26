# Skill Compatibility Matrix

This document shows which skills work with which AI coding platforms.

## Legend

| Platform | Description |
|----------|-------------|
| **Clawdbot** | Full Clawdbot agent with all tools |
| **Claude Code** | Claude Code CLI with read, write, exec, web_search, web_fetch |
| **Codex** | OpenAI Codex CLI with similar portable tool set |

## Quick Reference

### ✅ Universal (All Platforms)

These skills are pure instruction/methodology with no tool dependencies:

| Skill | Location |
|-------|----------|
| `planner` | `skills/planner` |
| `remotion` | `skills/remotion` |
| `frontend-design` | `prompts/frontend-design` |

### ✅ Portable (Claude Code + Codex + Clawdbot)

These skills use only portable tools (`read`, `write`, `exec`, `web_search`, `web_fetch`):

| Skill | Location | Tools Used |
|-------|----------|------------|
| `context-recovery` | `skills/context-recovery` | `message` (read-only) |
| `elegant-reports` | `skills/elegant-reports` | `exec` |
| `ga4` | `skills/ga4` | `exec` |
| `google-ads` | `skills/google-ads` | `exec`, `browser` |
| `gsc` | `skills/gsc` | `exec` |
| `jira` | `skills/jira` | `exec` |
| `nudocs` | `skills/nudocs` | `exec` |
| `parallel-task` | `skills/parallel-task` | `exec` |
| `sysadmin-toolbox` | `skills/sysadmin-toolbox` | `exec`, `read` |
| `task-orchestrator` | `skills/task-orchestrator` | `sessions_spawn` OR `exec` (has fallback) |
| `codex` | `codex/codex` | `exec` |
| `command-creator` | `codex/command-creator` | `write` |
| `gemini` | `codex/gemini` | `exec` |
| `self-improving-agent` | `clawdbot/self-improving-agent` | `read`, `write` |
| `skill-sync` | `clawdbot/skill-sync` | `exec` |
| `todo-tracker` | `clawdbot/todo-tracker` | `exec` |

### ⚠️ Clawdbot-Only

These skills require Clawdbot-specific tools:

| Skill | Location | Required Tools | Portability Notes |
|-------|----------|----------------|-------------------|
| `auto-updater` | `clawdbot/auto-updater` | `cron`, `message` | Needs alternative scheduler |
| `clawdbot-release-check` | `clawdbot/clawdbot-release-check` | `exec` | Actually portable! |
| `clawddocs` | `clawdbot/clawddocs` | Clawdbot docs | Clawdbot-specific content |
| `gallery-scraper` | `clawdbot/gallery-scraper` | `browser` | Needs browser automation |

## Tool Categories

**Clawdbot-only tools:**
- `message` — Send messages, reactions, channel operations
- `browser` — Browser automation
- `cron` — Scheduled jobs
- `nodes` — Device/node control
- `canvas` — Canvas presentation
- `sessions_spawn/send` — Multi-agent orchestration
- `gateway` — Clawdbot config/restart
- `tts` — Text-to-speech
- `memory_search/get` — Semantic memory

**Portable tools (available in Claude Code/Codex):**
- `read` — Read files
- `write` — Write files
- `exec` — Run shell commands
- `web_search` — Search the web
- `web_fetch` — Fetch URL content
- `image` — Analyze images

## Installation by Platform

### Claude Code / Codex

```bash
# Clone the repo
git clone https://github.com/jdrhyne/agent-skills.git

# Copy portable skills to your workspace
cp -r agent-skills/skills/* ~/.claude/skills/
cp -r agent-skills/codex/* ~/.claude/skills/
cp -r agent-skills/prompts/* ~/.claude/prompts/
```

### Clawdbot

```bash
# Clone to your workspace skills folder
cd ~/your-clawdbot-workspace/skills
git clone https://github.com/jdrhyne/agent-skills.git

# Or use skill-sync
# (if you have the skill-sync skill installed)
```

## External CLI Dependencies

Some skills require external tools to be installed:

| Skill | Required CLI | Install |
|-------|-------------|---------|
| `codex` | `codex` | `npm i -g @openai/codex` |
| `gemini` | `gemini` | Google Gemini CLI |
| `jira` | `jira` | Atlassian CLI |
| `ga4` | `gcloud` | Google Cloud SDK |
| `gsc` | `gcloud` | Google Cloud SDK |
| `nudocs` | `nudocs` | `npm i -g nudocs` |

---

*Generated: 2025-01-26*
