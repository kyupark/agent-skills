#!/bin/bash
#
# update-readme.sh
# Scans /skills folder (including subfolders) and updates README.md with skill list
#

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
README="$REPO_ROOT/README.md"

# Check if skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
  echo "No skills directory found"
  exit 0
fi

# Get skill info from SKILL.md
get_skill_info() {
  local skill_md="$1"
  local name description
  
  name=$(grep -E "^name:" "$skill_md" | head -1 | sed 's/name:[[:space:]]*//')
  description=$(sed -n '/^description:/,/^[a-z]*:/{ /^description:/{ s/description:[[:space:]]*//; s/^>//; p; }; /^[[:space:]]/{ s/^[[:space:]]*//; p; }; }' "$skill_md" | head -1 | tr -d '"')
  
  [ -z "$description" ] && description="No description"
  
  # Truncate long descriptions
  if [ ${#description} -gt 100 ]; then
    description="${description:0:97}..."
  fi
  
  echo "$name|$description"
}

# Generate skill list for top-level skills
generate_top_level_skills() {
  for skill_dir in "$SKILLS_DIR"/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name=$(basename "$skill_dir")
    
    # Skip if it's a category folder (contains subfolders with SKILL.md)
    if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
      info=$(get_skill_info "$skill_dir/SKILL.md")
      name=$(echo "$info" | cut -d'|' -f1)
      desc=$(echo "$info" | cut -d'|' -f2)
      [ -z "$name" ] && name="$skill_name"
      echo "- \`$name\`: $desc"
    fi
  done
}

# Generate skill list for a category
generate_category_skills() {
  local category="$1"
  local category_dir="$SKILLS_DIR/$category"
  
  for skill_dir in "$category_dir"/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name=$(basename "$skill_dir")
    
    if [ -f "$skill_dir/SKILL.md" ]; then
      info=$(get_skill_info "$skill_dir/SKILL.md")
      name=$(echo "$info" | cut -d'|' -f1)
      desc=$(echo "$info" | cut -d'|' -f2)
      [ -z "$name" ] && name="$skill_name"
      echo "- \`$name\`: $desc"
    fi
  done
}

# Create new README content
create_readme() {
  local in_skills=0
  local in_clawdbot=0
  
  while IFS= read -r line; do
    if [[ "$line" == "<!-- SKILLS_START -->" ]]; then
      echo "$line"
      generate_top_level_skills
      in_skills=1
    elif [[ "$line" == "<!-- SKILLS_END -->" ]]; then
      echo "$line"
      in_skills=0
    elif [[ "$line" == "<!-- CLAWDBOT_SKILLS_START -->" ]]; then
      echo "$line"
      generate_category_skills "clawdbot"
      in_clawdbot=1
    elif [[ "$line" == "<!-- CLAWDBOT_SKILLS_END -->" ]]; then
      echo "$line"
      in_clawdbot=0
    elif [[ $in_skills -eq 0 ]] && [[ $in_clawdbot -eq 0 ]]; then
      echo "$line"
    fi
  done < "$README"
}

# Update README
tmp_file=$(mktemp)
create_readme > "$tmp_file"
mv "$tmp_file" "$README"

top_count=$(ls -1d "$SKILLS_DIR"/*/ 2>/dev/null | while read d; do [ -f "$d/SKILL.md" ] && echo 1; done | wc -l | tr -d ' ')
clawdbot_count=$(ls -1d "$SKILLS_DIR/clawdbot"/*/ 2>/dev/null | wc -l | tr -d ' ')

echo "✓ Updated README.md with $top_count generic skills + $clawdbot_count Clawdbot skills"
