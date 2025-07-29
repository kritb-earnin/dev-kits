#!/bin/bash

set -e  # Exit on any error

# Get the absolute path of the current directory where scripts are located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEVKIT_SCRIPT="$SCRIPT_DIR/devkits"
START_BRANCH_SCRIPT="$SCRIPT_DIR/start-branch.sh"
ZSHRC_FILE="$HOME/.zshrc"

echo "🔧 Setting up DevKit developer toolkit..."

# Check if required scripts exist
if [[ ! -f "$DEVKIT_SCRIPT" ]]; then
    echo "❌ Error: devkits script not found at $DEVKIT_SCRIPT"
    exit 1
fi

if [[ ! -f "$START_BRANCH_SCRIPT" ]]; then
    echo "❌ Error: start-branch.sh not found at $START_BRANCH_SCRIPT"
    exit 1
fi

# Make sure scripts are executable
chmod +x "$DEVKIT_SCRIPT"
chmod +x "$START_BRANCH_SCRIPT"

# Create .zshrc if it doesn't exist
if [[ ! -f "$ZSHRC_FILE" ]]; then
    echo "📝 Creating .zshrc file..."
    touch "$ZSHRC_FILE"
fi

# Setup aliases
setup_alias() {
    local alias_name="$1"
    local alias_command="$2"
    local description="$3"
    
    # Check if the alias already exists
    if grep -q "alias $alias_name=" "$ZSHRC_FILE" 2>/dev/null; then
        echo "⚠️  Alias '$alias_name' already exists in .zshrc. Updating it..."
        # Remove existing alias
        sed -i.bak "/alias $alias_name=/d" "$ZSHRC_FILE"
    else
        echo "➕ Adding new alias '$alias_name' to .zshrc..."
    fi
    
    # Add the new alias
    echo "alias $alias_name=\"$alias_command\"" >> "$ZSHRC_FILE"
    echo "✅ Successfully added alias '$alias_name' - $description"
}

# Setup main devkits alias
setup_alias "devkits" "$DEVKIT_SCRIPT" "Main developer toolkit interface"

# Setup legacy gitnew alias for backward compatibility
setup_alias "gitnew" "$START_BRANCH_SCRIPT" "Create new git branch (legacy)"

echo ""
echo "📍 DevKits installed at: $DEVKIT_SCRIPT"
echo "📝 Aliases added to: $ZSHRC_FILE"
echo ""
echo "🔄 To use the aliases immediately, run: source ~/.zshrc"
echo "   Or simply restart your terminal"
echo ""
echo "🚀 You can now use:"
echo "   devkits          # Interactive developer toolkit"
echo "   devkits list     # Show all available commands"
echo "   devkits help     # Show help"
echo "   gitnew           # Legacy: create new branch"
