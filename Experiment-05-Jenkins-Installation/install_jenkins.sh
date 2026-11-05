
#!/usr/bin/env bash

# DevOps Laboratory - Experiment 5
# Jenkins Installation on Ubuntu

set -euo pipefail

echo "========================================"
echo "EXPERIMENT 5: JENKINS INSTALLATION"
echo "========================================"

if [ "$(id -u)" -eq 0 ]; then
    echo "Run as a normal user with sudo access."
    exit 1
fi

if [ ! -f /etc/os-release ]; then
    echo "Linux OS information not found."
    exit 1
fi

source /etc/os-release

if [ "$ID" != "ubuntu" ]; then
    echo "This script is intended for Ubuntu."
    exit 1
fi

if ! command -v systemctl >/dev/null 2>&1; then
    echo "Error: systemctl is required."
    exit 1
fi

echo ""
echo "STEP 1: Updating package index"
sudo apt-get update

echo ""
echo "STEP 2: Installing Java and utilities"
sudo apt-get install -y \
    fontconfig \
    openjdk-21-jre \
    wget \
    ca-certificates

echo ""
echo "STEP 3: Verifying Java"
java -version

echo ""
echo "STEP 4: Adding Jenkins signing key"
sudo wget -q -O \
    /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo ""
echo "STEP 5: Adding Jenkins LTS repository"

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
    | sudo tee \
    /etc/apt/sources.list.d/jenkins.list \
    >/dev/null

echo ""
echo "STEP 6: Installing Jenkins"
sudo apt-get update
sudo apt-get install -y jenkins

echo ""
echo "STEP 7: Enabling and starting Jenkins"
sudo systemctl enable --now jenkins

echo ""
echo "STEP 8: Checking Jenkins service"

if sudo systemctl is-active --quiet jenkins; then
    echo "Jenkins service is active."
else
    echo "Jenkins service is not active."
    exit 1
fi

echo ""
echo "STEP 9: Checking Jenkins port"

if sudo ss -ltn | grep -q ':8080 '; then
    echo "Port 8080 is listening."
else
    echo "Port 8080 is not listening yet."
    echo "Check Jenkins service logs."
fi

echo ""
echo "========================================"
echo "JENKINS INSTALLATION CHECK COMPLETED"
echo "========================================"

echo "Open http://localhost:8080"
echo "Complete the Jenkins setup wizard."
echo "Retrieve the initial password locally."
echo "Never publish the password."
