
#!/bin/bash

# Experiment 5: Jenkins Freestyle Job

set -e

echo "========================================"
echo "DEVOPS LABORATORY - EXPERIMENT 5"
echo "========================================"

echo ""
echo "Jenkins Freestyle Job Started"

echo ""
echo "Step 1: Display Build Information"
echo "Job Name: ${JOB_NAME:-Local-Demo}"
echo "Build Number: ${BUILD_NUMBER:-N/A}"

echo ""
echo "Step 2: Display System Information"
uname -s

echo ""
echo "Step 3: Display Current Directory"
pwd

echo ""
echo "Step 4: Execute Automation Task"

echo "Building sample application..."
sleep 1

echo "Running sample tests..."
sleep 1

echo "Sample automation steps completed."

echo ""
echo "========================================"
echo "BUILD COMPLETED SUCCESSFULLY"
echo "========================================"
