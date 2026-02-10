#!/bin/bash
# Test prepare-mode skill structure

SKILL_DIR="skills/prepare-mode"

if [ -d "$SKILL_DIR" ] && [ -f "$SKILL_DIR/SKILL.md" ]; then
  echo "STATUS: SUCCESS: prepare-mode skill structure verified"
else
  echo "STATUS: ERROR: prepare-mode skill structure missing"
  exit 1
fi
