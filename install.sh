#!/bin/bash

set -e  # Exit on any error

# Get the absolute path of the current directory where start-branch.sh is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
START_BRANCH_SCRIPT="$SCRIPT_DIR/start-branch.sh"
ZSHRC_FILE="$HOME/.zshrc"

echo "🔧 Setting up zsh alias 'gitnew'..."

# Check if start-branch.sh exists
if [[ ! -f "$START_BRANCH_SCRIPT" ]]; then
    echo "❌ Error: start-branch.sh not found at $START_BRANCH_SCRIPT"
    exit 1
fi

# Make sure start-branch.sh is executable
chmod +x "$START_BRANCH_SCRIPT"

# Create .zshrc if it doesn't exist
if [[ ! -f "$ZSHRC_FILE" ]]; then
    echo "📝 Creating .zshrc file..."
    touch "$ZSHRC_FILE"
fi

# Check if the alias already exists in .zshrc
if grep -q "alias gitnew=" "$ZSHRC_FILE" 2>/dev/null; then
    echo "⚠️  Alias 'gitnew' already exists in .zshrc. Updating it..."
    # Remove existing alias
    sed -i.bak '/alias gitnew=/d' "$ZSHRC_FILE"
else
    echo "➕ Adding new alias 'gitnew' to .zshrc..."
fi

# Add the new alias
echo "alias gitnew=\"$START_BRANCH_SCRIPT\"" >> "$ZSHRC_FILE"

echo "✅ Successfully added zsh alias 'gitnew'"
echo "📍 Alias points to: $START_BRANCH_SCRIPT"
echo "📝 Added to: $ZSHRC_FILE"
echo ""
echo "🔄 To use the alias immediately, run: source ~/.zshrc"
echo "   Or simply restart your terminal"
echo ""
echo "🚀 You can now use: gitnew"
echo "   This will checkout develop, pull latest changes, and create a new branch!"
