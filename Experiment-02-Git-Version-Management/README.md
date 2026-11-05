
# Experiment 2: Git Repository Creation and Version Management

## Aim

To create and manage a Git repository, track source-code changes, maintain version history, and understand local and remote repository operations using Git and GitHub.

## Objectives

1. Understand distributed version control.
2. Configure Git username and email.
3. Initialize a local Git repository.
4. Track modified, staged, and committed files.
5. Create commits and inspect version history.
6. Create and manage branches.
7. Connect a local repository to GitHub.
8. Practice pushing, pulling, and cloning repositories.
9. Understand pull requests and code reviews.

## Tools Required

- Git
- GitHub account
- Git Bash or Linux terminal
- Python 3
- Visual Studio Code (optional)

## Theory

### What is Version Control?

Version control is a system that records changes made to files over time.

It allows developers to restore previous versions, compare modifications, and collaborate on software projects.

### What is Git?

Git is a distributed version control system used to track source-code changes.

Every cloned Git repository contains a local copy of the project's version history.

### What is GitHub?

GitHub is a cloud-based platform that hosts Git repositories and provides collaboration features such as pull requests, issue tracking, and code reviews.

### Types of Version Control

**Centralized Version Control**

A central server maintains the repository history.

Example: Subversion (SVN).

**Distributed Version Control**

Each developer has a local repository containing project history.

Example: Git.

## Git Architecture

```text
          Working Directory
                  |
               git add
                  |
                  v
             Staging Area
                  |
             git commit
                  |
                  v
           Local Repository
                  |
               git push
                  |
                  v
          Remote Repository
               (GitHub)

Remote Repository
       |
    git pull
       |
       v
Local Branch and Working Directory
```

## Important Git States

1. Untracked: A new file that Git is not tracking.
2. Modified: A tracked file that has been changed.
3. Staged: A change selected for the next commit.
4. Committed: A change saved in Git history.

## Procedure

### Step 1: Verify Git Installation

```bash
git --version
```

### Step 2: Configure Git

Replace the placeholders with your own details.

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

Verify:

```bash
git config --global --list
```

### Step 3: Create a Local Repository

```bash
mkdir git-version-demo
cd git-version-demo
git init -b main
```

### Step 4: Create a Python Application

Create `main.py`:

```python
print("Welcome to DevOps Laboratory")
print("Git Version Management - Version 1")
```

### Step 5: Check Repository Status

```bash
git status
```

The new file initially appears as untracked.

### Step 6: Stage the File

```bash
git add main.py
```

Check the status again:

```bash
git status
```

The file is now staged.

### Step 7: Create the First Commit

```bash
git commit -m "Initial commit: add Python application"
```

### Step 8: Modify the Application

Update `main.py`:

```python
print("Welcome to DevOps Laboratory")
print("Git Version Management - Version 2")
print("Version control helps track code changes.")
```

Inspect the changes:

```bash
git diff
```

### Step 9: Commit the Updated Version

```bash
git add main.py
git commit -m "Update application to version 2"
```

### Step 10: View Commit History

```bash
git log --oneline
```

### Step 11: Create a Feature Branch

```bash
git switch -c feature-greeting
```

Add a new greeting to the Python application.

Commit the change:

```bash
git add main.py
git commit -m "Add greeting feature"
```

### Step 12: Merge the Feature Branch

```bash
git switch main
git merge feature-greeting
```

### Step 13: Connect to GitHub

Create an empty repository on GitHub named:

`git-version-demo`

Do not initialize it with a README or other files.

Then run:

```bash
git remote add origin https://github.com/YOUR_USERNAME/git-version-demo.git
git push -u origin main
```

Replace YOUR_USERNAME with your actual GitHub username.

Authenticate using a supported GitHub method when prompted.

### Step 14: Clone the Repository

From another directory:

```bash
git clone https://github.com/YOUR_USERNAME/git-version-demo.git
```

### Step 15: Synchronize Changes

Download and integrate remote changes:

```bash
git pull origin main
```

Upload new local commits:

```bash
git push origin main
```

### Step 16: Pull Requests and Code Reviews

1. Create a feature branch.
2. Commit changes.
3. Push the branch to GitHub.
4. Open a pull request targeting main.
5. Review the code changes.
6. Merge the pull request after approval.

## Important Git Commands

| Command | Purpose |
|---------|---------|
| git init | Initialize repository |
| git clone | Copy remote repository |
| git status | Display file status |
| git add | Stage changes |
| git commit | Save changes |
| git log | View commit history |
| git diff | Compare changes |
| git branch | Manage branches |
| git switch | Change branches |
| git merge | Merge branches |
| git remote | Manage remote repositories |
| git push | Upload commits |
| git pull | Fetch and integrate changes |
| git fetch | Download remote updates |

## Expected Output

- Git repository initialized successfully.
- Source files added and committed.
- File modifications tracked.
- Commit history displayed.
- Feature branch created and merged.
- Remote GitHub synchronization completed when configured.

## Applications

- Software version management
- Team collaboration
- Source-code backup
- Feature development
- Release management
- CI/CD integration

## Result

Git repository creation and version management operations are demonstrated using a sample Python application.

Local Git operations can be verified without a GitHub account. Remote synchronization and pull requests require a GitHub repository.

## Conclusion

This experiment demonstrates the fundamental operations of Git and GitHub, including repository initialization, staging, committing, branching, merging, and remote synchronization.

These concepts form the foundation for collaborative DevOps development.
