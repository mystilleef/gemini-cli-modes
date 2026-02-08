#!/bin/bash
# Test build-mode skill structure

SKILL_DIR="skills/build-mode"

if [ -d "$SKILL_DIR" ] && [ -f "$SKILL_DIR/SKILL.md" ]; then
  echo "STATUS: SUCCESS: build-mode skill structure verified"
else
  echo "STATUS: ERROR: build-mode skill structure missing"
  exit 1
fi
