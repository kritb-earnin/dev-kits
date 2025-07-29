# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a CLI developer toolkit repository with an interactive terminal interface designed to help new joiners and development teams discover and use development commands. The toolkit features a searchable command registry system and an extensible architecture for adding new scripts.

## Key Components

### Scripts
- `devkits` - Main terminal UI script with interactive command discovery, search functionality, and command execution
- `start-branch.sh` - Git workflow automation script: checks out default branch, pulls latest changes, and creates new feature branches
- `install.sh` - Installation script that sets up `devkits` and `gitnew` aliases in `.zshrc`

### Branch Management Logic
The `start-branch.sh` script intelligently determines the default branch by:
1. Checking `git symbolic-ref refs/remotes/origin/HEAD`
2. Falling back to checking remote branches in order: main, master, develop
3. Checking local branches as final fallback
4. Defaulting to "main" if all else fails

## Usage

### Installation
```bash
./install.sh
```
This sets up the `devkits` command and creates a legacy `gitnew` alias in your `.zshrc` file.

### Terminal UI Commands
```bash
devkits                   # Interactive mode with command discovery
devkits list              # Show all available commands
devkits search <term>     # Search for commands containing term
devkits run <command>     # Execute a specific command
devkits help              # Show help information
```

### Interactive Mode Commands
Within the interactive terminal:
- `list` - Show all available commands organized by category
- `search <term>` - Search for commands by name or description
- `run <command>` - Execute a specific command
- `help` - Show help information
- `exit/quit/q` - Exit the interactive mode

### Command Registry System
New commands are registered in the `devkits` script using:
```bash
register_command "name" "description" "script_path" "category"
```

## Architecture Notes

- **Terminal UI System**: The `devkits` script provides an interactive terminal interface with colored output and command discovery
- **Command Registry**: Uses associative arrays to store command information (name, description, script path, category)
- **Modular Design**: Easy to extend by adding new commands to the registry without modifying core functionality
- **Error Handling**: All scripts use `set -e` for proper error handling and provide user-friendly feedback
- **Cross-Shell Compatibility**: Installation system modifies `.zshrc` for persistent aliases
- **Dynamic Git Detection**: Intelligent default branch detection works across different repository configurations

## File Structure
```
dev-kits/
├── README.md          # Project documentation with usage guide
├── CLAUDE.md          # Claude Code guidance file
├── devkits            # Main terminal UI script (executable)
├── install.sh         # Installation script for setting up aliases
├── start-branch.sh    # Git branch creation utility
└── cacerts/          # Certificate files (empty directory)
```

## Development Notes

- **Error Handling**: All scripts should maintain the existing error handling pattern with `set -e`
- **User Experience**: User feedback uses emoji prefixes and colored output for better CLI experience
- **Input Validation**: Scripts validate input and check for existing branches/conflicts to prevent errors
- **Extensibility**: To add new commands, register them in the `init_commands()` function in the `devkits` script
- **Testing**: Test the interactive interface by running `devkits` and trying all commands
- **Cross-Repository**: The tool is designed to work across different git repository configurations

## Common Development Tasks

- **Add New Command**: Edit `devkits` script and add to `init_commands()` function
- **Test Installation**: Run `./install.sh` to set up aliases
- **Test Interactive Mode**: Run `devkits` to test the terminal UI
- **Validate All Commands**: Use `devkits list` to ensure all commands are properly registered