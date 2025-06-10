#!/bin/bash

# A script to checkout default branch and create a new branch using Jira ID. 

set -e  # Exit on any error

# Function to get the default branch dynamically
get_default_branch() {
    # Try to get the default branch from remote HEAD
    if default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null); then
        # Strip the "refs/remotes/origin/" prefix
        echo "${default_branch#refs/remotes/origin/}"
        return 0
    fi
    
    # If remote HEAD is not set, try to determine from remote branches
    if git ls-remote --heads origin main &>/dev/null; then
        echo "main"
        return 0
    elif git ls-remote --heads origin master &>/dev/null; then
        echo "master"
        return 0
    elif git ls-remote --heads origin develop &>/dev/null; then
        echo "develop"
        return 0
    fi
    
    # Fallback: check local branches
    for branch in main master develop; do
        if git show-ref --verify --quiet refs/heads/$branch; then
            echo "$branch"
            return 0
        fi
    done
    
    # Ultimate fallback
    echo "main"
}

# Get the default branch
default_branch=$(get_default_branch)

echo "🔄 Checking out default branch: $default_branch..."
git checkout "$default_branch"

echo "📥 Pulling latest changes from $default_branch..."
git pull origin "$default_branch"

echo ""
read -p "Enter the new branch name (e.g., JIRA-123 or feature/your-feature): " branch_name

# Validate that branch name is not empty
if [[ -z "$branch_name" ]]; then
    echo "❌ Error: Branch name cannot be empty"
    exit 1
fi

# Check if branch already exists locally
if git show-ref --verify --quiet refs/heads/$branch_name; then
    echo "❌ Error: Branch '$branch_name' already exists locally"
    exit 1
fi

echo "🌿 Creating and checking out new branch: $branch_name"
git checkout -b "$branch_name"

echo "✅ Successfully created and switched to branch: $branch_name"
echo "🚀 You're ready to start working!"
