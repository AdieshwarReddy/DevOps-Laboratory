
#!/bin/bash

# Experiment 4: GitHub Collaboration
# Run inside a clean demo Git repository

set -e

echo "========================================"
echo "EXPERIMENT 4: GITHUB COLLABORATION"
echo "========================================"

# Check prerequisites
for tool in git python3; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Error: $tool is not installed."
        exit 1
    fi
done

if ! git rev-parse --is-inside-work-tree \
    >/dev/null 2>&1; then
    echo "Error: Run inside a Git repository."
    exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
    echo "Error: Working tree must be clean."
    exit 1
fi

echo ""
echo "STEP 1: Checking Git repository"
git status --short --branch

# Check that main exists
if ! git show-ref --verify --quiet refs/heads/main; then
    echo "Error: Local main branch not found."
    exit 1
fi

git switch main

# Create feature branch
echo ""
echo "STEP 2: Creating feature branch"

git switch -c feature-greeting

# Create application
cat > main.py <<'PYTHON'
def greet(name):
    return f"Hello, {name}! Welcome to DevOps."


if __name__ == "__main__":
    print(greet("Student"))
PYTHON

# Create initial unit test
cat > test_main.py <<'PYTHON'
import unittest
from main import greet


class TestGreeting(unittest.TestCase):
    def test_greeting(self):
        self.assertEqual(
            greet("Student"),
            "Hello, Student! Welcome to DevOps."
        )


if __name__ == "__main__":
    unittest.main()
PYTHON

echo ""
echo "STEP 3: Running initial tests"

python3 -m unittest -v

# Commit changes
git add main.py test_main.py
git commit -m "Add greeting application and unit test"

echo ""
echo "STEP 4: Feature commit created"

echo ""
echo "STEP 5: Push feature branch"

echo "Run:"
echo "git push -u origin feature-greeting"

echo ""
echo "STEP 6: Create Pull Request"
echo "Open GitHub and create a PR into main."

echo ""
echo "STEP 7: Perform Code Review"
echo "Request review and address feedback."

echo ""
echo "STEP 8: Merge Approved PR"
echo "Merge after approval and passing tests."

echo ""
echo "========================================"
echo "LOCAL COLLABORATION SETUP COMPLETED"
echo "========================================"
