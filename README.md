# Developer Toolkit (dev-kits)

A comprehensive CLI developer toolkit with an interactive terminal interface for new joiners and development teams.

## Features

### 🚀 Interactive Terminal UI
- **Command Discovery**: Search and browse available development commands
- **Interactive Mode**: User-friendly terminal interface with colored output
- **Extensible**: Easy to add new commands and scripts

### 📋 Available Commands
- **new-branch**: Create a new git branch from the default branch (main/master/develop)
- **gitnew**: Legacy alias for new-branch command

## Quick Start

### Installation
```bash
./install.sh
```

This will:
- Set up the `devkits` command in your shell
- Create a legacy `gitnew` alias for backward compatibility
- Make all scripts executable

### Usage

#### Interactive Mode
```bash
devkits
```
Start the interactive terminal interface where you can:
- Browse all available commands
- Search for specific functionality
- Execute commands directly

#### Command Line Usage
```bash
devkits list                   # Show all available commands
devkits search <term>          # Search for commands
devkits run <command>          # Execute a specific command
devkits help                   # Show help information
```

#### Direct Command Execution
```bash
devkits new-branch             # Create a new git branch
gitnew                         # Legacy: same as new-branch
```

## For New Joiners

This toolkit is designed to help new team members quickly discover and use development commands. Simply run `devkits` to start the interactive interface and explore available tools.

## Adding New Commands

To add a new command to the toolkit:

1. Create your script in the repository
2. Edit the `devkits` script and add your command to the `init_commands()` function:
   ```bash
   register_command "command-name" "Description" "$SCRIPT_DIR/your-script.sh" "Category"
   ```
3. Make sure your script is executable (`chmod +x your-script.sh`)

The command will automatically appear in the interactive interface and be searchable. 
