#!/bin/bash
# Test plan-mode skill structure

SKILL_DIR="skills/plan-mode"

if [ -d "$SKILL_DIR" ] && [ -f "$SKILL_DIR/SKILL.md" ]; then
  echo "STATUS: SUCCESS: plan-mode skill structure verified"
else
  echo "STATUS: ERROR: plan-mode skill structure missing"
  exit 1
fi
