
#!/usr/bin/env bash

# DevOps Laboratory - Experiment 6
# Build Verification Script

set -euo pipefail

echo "========================================"
echo "BUILD STAGE STARTED"
echo "========================================"

echo ""
echo "Step 1: Verify Python installation"
python3 --version

echo ""
echo "Step 2: Validate Python syntax"
python3 - <<'PYTHON'
import ast
from pathlib import Path

for filename in ("app.py", "test_app.py"):
    source = Path(filename).read_text(
        encoding="utf-8"
    )
    ast.parse(source, filename=filename)
    print(f"Syntax verified: {filename}")
PYTHON

echo ""
echo "Step 3: Execute application"
python3 app.py

echo ""
echo "========================================"
echo "BUILD COMPLETED SUCCESSFULLY"
echo "========================================"
