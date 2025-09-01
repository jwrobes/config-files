#!/bin/bash
# Git status script for tmux status bar

# Get current working directory from tmux pane
current_dir=$(tmux display-message -p '#{pane_current_path}')

# Change to that directory
cd "$current_dir" 2>/dev/null || exit 0

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    exit 0
fi

# Get current branch name
branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

# Get git status
status=""
if ! git diff-index --quiet HEAD 2>/dev/null; then
    status="*"  # Modified files
fi

if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
    if [[ "$status" == "" ]]; then
        status="+"  # Untracked files only
    else
        status="*+"  # Both modified and untracked
    fi
fi

# Format output in bold if there's a branch
if [ -n "$branch" ]; then
    # Get the git repository name from the working tree root directory
    # This shows the actual repository folder name (e.g., "my-project" for /path/to/my-project)
    # Works regardless of which subdirectory you're currently in within the repo
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$git_root" ]; then
        repo_name=$(basename "$git_root")
        echo "#[bold]${repo_name}:${branch}${status}#[nobold]"
    else
        # Fallback to current directory name if git commands fail
        folder_name=$(basename "$current_dir")
        echo "#[bold]${folder_name}:${branch}${status}#[nobold]"
    fi
fi
