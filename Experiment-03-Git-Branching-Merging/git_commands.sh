
#!/bin/bash

# DevOps Laboratory - Experiment 3
# Git Branching, Merging and Conflict Resolution

set -e

echo "========================================"
echo "EXPERIMENT 3: GIT BRANCHING AND MERGING"
echo "========================================"

if ! command -v git >/dev/null 2>&1; then
    echo "Error: Git is not installed."
    exit 1
fi

# Create a separate demonstration repository
DEMO_DIR=$(mktemp -d)
cd "$DEMO_DIR"

git init -q -b main
git config user.name "DevOps Lab Student"
git config user.email "devops-lab@example.invalid"

echo ""
echo "STEP 1: Git repository initialized"

# Initial file
cat > main.py <<'PYTHON'
print("Welcome to DevOps Laboratory")
print("Application Version 1")
PYTHON

git add main.py
git commit -q -m "Initial commit"

echo "STEP 2: Initial commit created"

# Feature branch
git switch -q -c feature-update

cat > main.py <<'PYTHON'
print("Welcome to DevOps Laboratory")
print("Feature branch update")
PYTHON

git add main.py
git commit -q -m "Update feature branch"

echo "STEP 3: Feature branch created and committed"

# Merge feature branch
git switch -q main
git merge -q feature-update

echo "STEP 4: Feature branch merged into main"

# Prepare common ancestor for conflict
echo "Application Status: Initial" > message.txt

git add message.txt
git commit -q -m "Add initial status"

# Conflict branch changes
git switch -q -c conflict-demo

echo "Application Status: Updated by feature branch" \
    > message.txt

git add message.txt
git commit -q -m "Feature branch status update"

echo "STEP 5: Conflict branch created"

# Main branch changes
git switch -q main

echo "Application Status: Updated by main branch" \
    > message.txt

git add message.txt
git commit -q -m "Main branch status update"

echo "STEP 6: Conflicting main branch change committed"

# Attempt merge
echo ""
echo "STEP 7: Attempting conflicting merge"

if git merge conflict-demo; then
    echo "Unexpected result: merge completed without conflict."
    exit 1
else
    echo "Expected merge conflict detected."
fi

# Verify unresolved conflict
if ! git ls-files -u | grep -q .; then
    echo "Error: No unresolved conflict found."
    exit 1
fi

echo ""
echo "STEP 8: Conflict markers"

cat message.txt

# Resolve conflict
cat > message.txt <<'TEXT'
Application Status: Updated by main and feature branches
TEXT

git add message.txt
git commit -q -m "Resolve merge conflict"

echo ""
echo "STEP 9: Conflict resolved and committed"

echo ""
echo "STEP 10: Final file content"
cat message.txt

echo ""
echo "STEP 11: Branch list"
git branch

echo ""
echo "STEP 12: Commit history"
git log --oneline --graph --all

echo ""
echo "STEP 13: Final repository status"
git status --short --branch

echo ""
echo "Demonstration repository: $DEMO_DIR"
echo "GitHub push requires a remote repository."

echo ""
echo "========================================"
echo "EXPERIMENT 3 COMPLETED SUCCESSFULLY"
echo "========================================"
