#!/bin/bash
# Test review-mode skill structure

SKILL_DIR="skills/review-mode"

if [ -d "$SKILL_DIR" ] && [ -f "$SKILL_DIR/SKILL.md" ]; then
  echo "STATUS: SUCCESS: review-mode skill structure verified"
else
  echo "STATUS: ERROR: review-mode skill structure missing"
  exit 1
fi
