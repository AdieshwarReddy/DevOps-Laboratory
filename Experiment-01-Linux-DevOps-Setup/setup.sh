#This script checks the environment and installs missing basic tools on Ubuntu. Docker installation is handled separately through the README because its service configuration depends on the environment.

#!/bin/bash

# Experiment 1: Linux and DevOps Toolchain Setup
# DevOps Laboratory
# Malla Reddy University

set -e

echo "========================================"
echo "EXPERIMENT 1: DEVOPS ENVIRONMENT SETUP"
echo "========================================"

# STEP 1: Check Operating System

echo ""
echo "STEP 1: Checking Operating System"

if [ ! -f /etc/os-release ]; then
    echo "Error: Linux OS information not found."
    exit 1
fi

source /etc/os-release
echo "Operating System: $PRETTY_NAME"

# STEP 2: Verify Ubuntu

if [ "$ID" != "ubuntu" ]; then
    echo "This script supports Ubuntu only."
    exit 1
fi

# STEP 3: Update Package List

echo ""
echo "STEP 2: Updating Package List"

sudo apt-get update

# STEP 4: Install Basic Tools

echo ""
echo "STEP 3: Installing DevOps Tools"

sudo apt-get install -y \
    git \
    curl \
    wget \
    python3 \
    python3-pip

# STEP 5: Verify Git

echo ""
echo "STEP 4: Checking Git"

git --version

# STEP 6: Verify Python

echo ""
echo "STEP 5: Checking Python"

python3 --version

# STEP 7: Verify curl

echo ""
echo "STEP 6: Checking curl"

curl --version | head -n 1

# STEP 8: Verify Docker

echo ""
echo "STEP 7: Checking Docker"

if command -v docker >/dev/null 2>&1; then
    docker --version

    if sudo docker info >/dev/null 2>&1; then
        echo "Docker daemon is running."
    else
        echo "Docker installed, but daemon unavailable."
    fi
else
    echo "Docker is not installed."
    echo "Follow README.md for Docker setup."
fi

# STEP 9: Display Result

echo ""
echo "========================================"
echo "DEVOPS ENVIRONMENT CHECK COMPLETED"
echo "========================================"

echo "Basic DevOps tools are ready."
echo "Review Docker status above."
