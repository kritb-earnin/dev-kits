#!/bin/bash

# NVM (Node Version Manager) Installation Script
# Installs nvm and sets up Node.js environment for development

set -e  # Exit on any error

echo "🚀 Installing NVM (Node Version Manager)..."
echo ""

# Check if nvm is already installed
if command -v nvm &> /dev/null; then
    echo "⚠️  NVM is already installed!"
    echo "Current version: $(nvm --version)"
    echo ""
    read -p "Do you want to reinstall/update NVM? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "✅ Keeping existing NVM installation"
        exit 0
    fi
    echo ""
fi

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo "❌ Error: curl is required but not installed"
    echo "Please install curl first:"
    echo "  macOS: curl should be pre-installed"
    echo "  Linux: sudo apt-get install curl (Ubuntu/Debian) or sudo yum install curl (CentOS/RHEL)"
    exit 1
fi

# Download and install nvm
echo "📥 Downloading and installing NVM..."
NVM_VERSION="v0.39.0"  # Latest stable version as of script creation
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "✅ NVM installation completed successfully!"
else
    echo "❌ NVM installation failed"
    exit 1
fi

echo ""
echo "🔧 Setting up shell configuration..."

# Determine shell and config file
SHELL_NAME=$(basename "$SHELL")
case "$SHELL_NAME" in
    "bash")
        SHELL_CONFIG="$HOME/.bashrc"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            SHELL_CONFIG="$HOME/.bash_profile"
        fi
        ;;
    "zsh")
        SHELL_CONFIG="$HOME/.zshrc"
        ;;
    *)
        echo "⚠️  Unsupported shell: $SHELL_NAME"
        echo "Please manually add NVM to your shell configuration"
        SHELL_CONFIG=""
        ;;
esac

# Add nvm to shell config if not already present
if [[ -n "$SHELL_CONFIG" ]]; then
    NVM_LINES='
# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'

    if ! grep -q "NVM_DIR" "$SHELL_CONFIG" 2>/dev/null; then
        echo "$NVM_LINES" >> "$SHELL_CONFIG"
        echo "✅ Added NVM configuration to $SHELL_CONFIG"
    else
        echo "ℹ️  NVM configuration already exists in $SHELL_CONFIG"
    fi
fi

echo ""
echo "🎉 NVM installation complete!"
echo ""
echo "📝 Next steps:"
echo "1. Restart your terminal or run: source $SHELL_CONFIG"
echo "2. Verify installation: nvm --version"
echo "3. Install Node.js: nvm install node"
echo "4. Use specific version: nvm install 18.17.0"
echo "5. List available versions: nvm ls-remote"
echo ""
echo "🔗 Useful NVM commands:"
echo "  nvm install node          # Install latest Node.js"
echo "  nvm install 18.17.0       # Install specific version"
echo "  nvm use 18.17.0           # Switch to specific version"
echo "  nvm ls                    # List installed versions"
echo "  nvm alias default 18.17.0 # Set default version"
echo ""
echo "📚 Documentation: https://github.com/nvm-sh/nvm#usage"