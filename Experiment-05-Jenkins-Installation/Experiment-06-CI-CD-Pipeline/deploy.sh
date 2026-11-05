
#!/usr/bin/env bash

# DevOps Laboratory - Experiment 6
# Local Deployment Script

set -euo pipefail

echo "========================================"
echo "DEPLOY STAGE STARTED"
echo "========================================"

DEPLOY_DIR="deployment"

echo ""
echo "Step 1: Creating deployment directory"
mkdir -p "$DEPLOY_DIR"

echo ""
echo "Step 2: Copying application"
cp app.py "$DEPLOY_DIR/app.py"

echo ""
echo "Step 3: Verifying deployed file"

if [ -f "$DEPLOY_DIR/app.py" ]; then
    echo "Deployment file verified."
else
    echo "Deployment failed."
    exit 1
fi

echo ""
echo "Step 4: Running deployed application"
python3 "$DEPLOY_DIR/app.py"

echo ""
echo "========================================"
echo "DEPLOYMENT COMPLETED SUCCESSFULLY"
echo "========================================"
