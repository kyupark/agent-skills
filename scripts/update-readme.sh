#!/bin/bash
#
# update-readme.sh
# Scans /skills folder and updates README.md with skill list
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

# Generate skill list
generate_skill_list() {
  for skill_dir in "$SKILLS_DIR"/*/; do
    [ -d "$skill_dir" ] || continue
    
    skill_name=$(basename "$skill_dir")
    skill_md="$skill_dir/SKILL.md"
    
    if [ -f "$skill_md" ]; then
      # Extract name from frontmatter
      name=$(grep -E "^name:" "$skill_md" | head -1 | sed 's/name:[[:space:]]*//')
      
      # Extract description - handle single line or multiline
      description=$(sed -n '/^description:/,/^[a-z]*:/{ /^description:/{ s/description:[[:space:]]*//; s/^>//; p; }; /^[[:space:]]/{ s/^[[:space:]]*//; p; }; }' "$skill_md" | head -1 | tr -d '"')
      
      # Use folder name if no name in frontmatter
      [ -z "$name" ] && name="$skill_name"
      [ -z "$description" ] && description="No description"
      
      # Truncate long descriptions
      if [ ${#description} -gt 120 ]; then
        description="${description:0:117}..."
      fi
      
      echo "- \`$name\`: $description"
    else
      echo "- \`$skill_name\`: *(missing SKILL.md)*"
    fi
  done
}

# Create new README content
create_readme() {
  local skill_list
  skill_list=$(generate_skill_list)
  
  # Read README and replace between markers
  local in_skills=0
  while IFS= read -r line; do
    if [[ "$line" == "<!-- SKILLS_START -->" ]]; then
      echo "$line"
      echo "$skill_list"
      in_skills=1
    elif [[ "$line" == "<!-- SKILLS_END -->" ]]; then
      echo "$line"
      in_skills=0
    elif [[ $in_skills -eq 0 ]]; then
      echo "$line"
    fi
  done < "$README"
}

# Update README
tmp_file=$(mktemp)
create_readme > "$tmp_file"
mv "$tmp_file" "$README"

skill_count=$(ls -1d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ')
echo "✓ Updated README.md with $skill_count skills"
