#!/usr/bin/env bash

# Read input from stdin (required for hook compatibility)
input=$(cat)

set -e  # Exit on error

# Install bd globally
if ! command -v bd &> /dev/null; then
    echo "Installing @beads/bd from npm..."
    volta install @beads/bd --quiet
fi

# Verify installation
if ! bd version &> /dev/null; then
    echo "✗ bd installation failed"
    exit 2
fi

# Initialize if needed
if [ ! -d .beads ]; then
    echo "Initializing bd in project..."
    # bd init --quiet
    bd init --quiet --stealth
fi

# Show ready work
echo "✓ bd is ready!"
exit 0
