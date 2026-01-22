# AGENTS.md

Instructions for AI agents working on this repository.

## Repository Purpose

This is a collection of AI agent skills. Each skill in `/skills` is a self-contained module that teaches an AI agent how to perform a specific task.

## Adding a New Skill

1. Create a new folder in `/skills`:
   ```
   skills/my-new-skill/
   ```

2. Create `SKILL.md` with proper frontmatter:
   ```markdown
   ---
   name: my-new-skill
   description: Brief one-line description of what this skill does
   ---

   # My New Skill

   Detailed instructions...
   ```

3. Add any supporting files:
   - `scripts/` — Helper scripts
   - `templates/` — Template files
   - `examples/` — Example inputs/outputs
   - `README.md` — Additional documentation

4. Run validation:
   ```bash
   ./scripts/validate-skills.sh
   ```

5. Update the README:
   ```bash
   ./scripts/update-readme.sh
   ```

## SKILL.md Format

Required frontmatter fields:
- `name`: Skill identifier (lowercase, hyphens)
- `description`: One-line description

Optional frontmatter:
- `version`: Semantic version
- `author`: Creator name
- `tags`: Comma-separated tags

### Structure Guidelines

1. **Start with Quick Reference** — Show usage examples immediately
2. **Be Specific** — Concrete commands, not vague instructions
3. **Include Examples** — Show inputs and expected outputs
4. **Document Edge Cases** — What to do when things go wrong
5. **Keep It Scannable** — Use headers, lists, code blocks

## Conventions

- Skill names: lowercase with hyphens (`elegant-reports`, not `ElegantReports`)
- Scripts should be executable (`chmod +x`)
- Include `.env.example` if skill needs environment variables
- Prefer shell scripts for simple automation, Node.js for complex logic

## Testing Skills

Before committing, verify:
1. `SKILL.md` has valid frontmatter
2. All scripts are executable
3. No hardcoded paths specific to one machine
4. README is updated with new skill

## File Locations

```
jdrhyne-skills/
├── README.md           # Main documentation (auto-updated)
├── AGENTS.md           # This file
├── scripts/
│   ├── update-readme.sh
│   └── validate-skills.sh
└── skills/
    └── skill-name/
        ├── SKILL.md    # Required
        └── ...         # Supporting files
```
