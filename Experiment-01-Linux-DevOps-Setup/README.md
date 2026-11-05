# DevOps-Laboratory
DevOps Laboratory experiments covering Linux, Git, GitHub, Jenkins, CI/CD pipelines, Docker, Kubernetes, automation, deployment, and monitoring. Includes step-by-step procedures, configuration files, commands, sample outputs, and documentation for B.Tech CSE (AI &amp; ML) students.



# Experiment 1: Installation and Setup of Linux Environment and DevOps Toolchain

## Aim

To install and configure a Linux environment and set up essential DevOps tools for software development, automation, and deployment.

## Objectives

1. Understand the importance of Linux in DevOps.
2. Install and configure an Ubuntu Linux environment.
3. Learn basic Linux commands.
4. Install essential DevOps tools.
5. Verify the installation of each tool.
6. Prepare the environment for future DevOps experiments.

## Theory

### What is DevOps?

DevOps combines software development (Dev) and IT operations (Ops).

It promotes collaboration, automation, continuous integration, continuous delivery, monitoring, and reliable software deployment.

### What is Linux?

Linux is an open-source operating system widely used for servers, cloud computing, development, and DevOps automation.

Linux provides command-line tools for managing files, processes, software packages, and services.

### What is a DevOps Toolchain?

A DevOps toolchain is a collection of tools used throughout the software development and deployment lifecycle.

Examples include:

- Git: Version control
- Docker: Containerization
- Jenkins: Continuous Integration and Delivery
- Kubernetes: Container orchestration
- Ansible: Configuration management

### Tools Used in This Experiment

**Ubuntu Linux**

Provides the operating system environment.

**Git**

Tracks source-code changes and supports collaboration.

**Python**

Supports scripting and automation.

**curl**

Transfers data and communicates with web services.

**Docker**

Packages and runs applications inside containers.

## Architecture

```text
        Windows Operating System
                  |
                  v
                 WSL2
                  |
                  v
              Ubuntu Linux
                  |
                  v
          DevOps Environment
                  |
        +---------+---------+
        |         |         |
        v         v         v
       Git      Python    Docker
        |         |         |
        +---------+---------+
                  |
                  v
          Environment Ready
```

## Requirements

- Windows 10/11 with WSL2 support, or an Ubuntu Linux machine
- Administrator access for installation
- Internet connection
- Sufficient disk space
- Terminal access

## Procedure

### Step 1: Install Ubuntu Using WSL

Open Windows PowerShell as Administrator.

Execute:

```powershell
wsl --install -d Ubuntu
```

Restart Windows if requested.

Launch Ubuntu and create your Linux username and password.

If Ubuntu is already installed, skip this step.

### Step 2: Update Linux Packages

Open the Ubuntu terminal.

```bash
sudo apt update
sudo apt upgrade -y
```

### Step 3: Install Essential Tools

```bash
sudo apt install -y git curl wget python3 python3-pip
```

### Step 4: Verify Git

```bash
git --version
```

### Step 5: Verify Python

```bash
python3 --version
```

### Step 6: Verify curl

```bash
curl --version
```

### Step 7: Install Docker

For this introductory setup, install Docker from Ubuntu's package repository:

```bash
sudo apt install -y docker.io
```

On a WSL2 installation with systemd enabled, start Docker:

```bash
sudo systemctl enable --now docker
```

Verify:

```bash
docker --version
sudo docker info
```

If systemd is not enabled, configure WSL systemd support before attempting to start the Docker service.

### Step 8: Run Setup Script

Navigate to the experiment folder and execute:

```bash
chmod +x setup.sh
./setup.sh
```

### Step 9: Verify Installation

Check that Git, Python, curl, and Docker are installed.

The script displays the installed tool versions and Docker service status.

## Basic Linux Commands

| Command | Description |
|---------|-------------|
| pwd | Display current directory |
| ls | List files and folders |
| cd | Change directory |
| mkdir | Create a directory |
| touch | Create an empty file |
| cp | Copy files |
| mv | Move or rename files |
| rm | Remove files |
| sudo | Execute with elevated privileges |
| apt | Manage Ubuntu packages |

## Expected Result

The Ubuntu Linux environment is configured successfully.

Essential DevOps tools are installed and their versions can be displayed using terminal commands.

## Advantages

1. Provides a development environment for DevOps practice.
2. Supports command-line automation.
3. Enables version control using Git.
4. Supports containerization through Docker.
5. Prepares the system for later DevOps experiments.

## Applications

- Software Development
- CI/CD Automation
- Cloud Computing
- Container Management
- Server Administration
- Infrastructure Automation

## Conclusion

This experiment demonstrates the installation and configuration of a Linux environment and essential DevOps tools.

The configured environment provides a foundation for future experiments involving Git, Jenkins, Docker, and Kubernetes.
