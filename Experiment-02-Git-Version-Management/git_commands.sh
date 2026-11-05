
#!/bin/bash

# Experiment 2: Git Version Management
# Malla Reddy University

set -e

echo "========================================"
echo "EXPERIMENT 2: GIT VERSION MANAGEMENT"
echo "========================================"

# Check Git
if ! command -v git >/dev/null 2>&1; then
    echo "Error: Git is not installed."
    exit 1
fi

# Create an isolated demonstration repository
DEMO_DIR=$(mktemp -d)
cd "$DEMO_DIR"

# Configure author identity only for this demo
git init -q -b main
git config user.name "DevOps Lab Student"
git config user.email "devops-lab@example.invalid"

echo ""
echo "STEP 1: Repository initialized"
git status --short --branch

# Create first version
cat > main.py <<'PYTHON'
print("Welcome to DevOps Laboratory")
print("Git Version Management - Version 1")
PYTHON

echo ""
echo "STEP 2: File created"
git status --short

# Stage first version
git add main.py

echo ""
echo "STEP 3: File staged"
git status --short

# First commit
git commit -q -m "Initial commit: version 1"

echo ""
echo "STEP 4: Initial commit completed"

# Modify the file
cat > main.py <<'PYTHON'
print("Welcome to DevOps Laboratory")
print("Git Version Management - Version 2")
print("Version control helps track code changes.")
PYTHON

echo ""
echo "STEP 5: Modified file"
git status --short

echo ""
echo "STEP 6: View changes"
git diff -- main.py

# Commit second version
git add main.py
git commit -q -m "Update application to version 2"

echo ""
echo "STEP 7: Second commit completed"

# Create a feature branch
git switch -q -c feature-greeting

cat >> main.py <<'PYTHON'
print("Feature: Welcome to Git and GitHub!")
PYTHON

git add main.py
git commit -q -m "Add greeting feature"

echo ""
echo "STEP 8: Feature branch committed"

# Merge into main
git switch -q main
git merge -q --no-ff feature-greeting \
    -m "Merge greeting feature"

echo ""
echo "STEP 9: Feature branch merged"

# Display commit history
echo ""
echo "STEP 10: Commit history"
git log --oneline --graph --all

# Run the final application
echo ""
echo "STEP 11: Execute final application"
python3 main.py

# Verify clean working tree
echo ""
echo "STEP 12: Final repository status"
git status --short --branch

echo ""
echo "Demo repository: $DEMO_DIR"
echo "Remote GitHub operations require manual setup."

echo ""
echo "========================================"
echo "GIT VERSION MANAGEMENT COMPLETED"
echo "========================================"
