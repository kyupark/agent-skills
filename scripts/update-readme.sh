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
  local skills_md=""
  
  for skill_dir in "$SKILLS_DIR"/*/; do
    [ -d "$skill_dir" ] || continue
    
    skill_name=$(basename "$skill_dir")
    skill_md="$skill_dir/SKILL.md"
    
    if [ -f "$skill_md" ]; then
      # Extract frontmatter
      name=$(grep -E "^name:" "$skill_md" | head -1 | sed 's/name:[[:space:]]*//')
      description=$(grep -E "^description:" "$skill_md" | head -1 | sed 's/description:[[:space:]]*//')
      
      # If description spans multiple lines (using >), get next line
      if [ -z "$description" ] || [ "$description" = ">" ]; then
        description=$(awk '/^description:/{found=1; next} found && /^[[:space:]]+/{gsub(/^[[:space:]]+/, ""); print; exit}' "$skill_md")
      fi
      
      # Use folder name if no name in frontmatter
      [ -z "$name" ] && name="$skill_name"
      [ -z "$description" ] && description="No description"
      
      skills_md+="- \`$name\`: $description"$'\n'
    else
      skills_md+="- \`$skill_name\`: *(missing SKILL.md)*"$'\n'
    fi
  done
  
  if [ -z "$skills_md" ]; then
    echo "*No skills installed yet. Add skills to the \`/skills\` folder.*"
  else
    echo "$skills_md"
  fi
}

# Update README between markers
update_readme() {
  local skill_list
  skill_list=$(generate_skill_list)
  
  # Create temp file
  local tmp_file=$(mktemp)
  
  # Process README
  awk -v skills="$skill_list" '
    /<!-- SKILLS_START -->/ {
      print
      print skills
      skip = 1
      next
    }
    /<!-- SKILLS_END -->/ {
      skip = 0
    }
    !skip {
      print
    }
  ' "$README" > "$tmp_file"
  
  mv "$tmp_file" "$README"
  echo "✓ Updated README.md with $(ls -1d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ') skills"
}

# Run
update_readme
