
# Experiment 3: Branching, Merging, and Conflict Resolution Using GitHub

## Aim

To understand and perform Git branching, merging, and merge conflict resolution using GitHub in a collaborative software development environment.

## Objectives

1. Create and manage Git branches.
2. Switch between branches safely.
3. Make independent commits on different branches.
4. Merge changes into the main branch.
5. Identify and reproduce merge conflicts.
6. Resolve conflicts by editing conflicting files.
7. Verify the final commit history.
8. Push the updated repository to GitHub.

## Requirements

- Git
- GitHub account
- Linux terminal, WSL, or Git Bash
- Python 3
- VS Code or another text editor
- Internet connection for GitHub operations

## Theory

### What is Git?

Git is a distributed version control system that tracks changes in source-code files.

It allows developers to collaborate, manage different versions, and restore earlier changes.

### What is Branching?

Branching creates an independent line of development.

Developers can work on new features or bug fixes without directly modifying the main branch.

Example:

A developer creates a branch named `feature-login` to develop a login feature.

### What is Merging?

Merging combines changes from one branch into another branch.

For example:

```bash
git switch main
git merge feature-login
```

This integrates changes from `feature-login` into `main`.

### What is a Merge Conflict?

A merge conflict occurs when Git cannot automatically combine changes.

A common example is when two branches modify the same line of a file differently.

Git marks the conflicting section and requires manual resolution.

### What is Conflict Resolution?

Conflict resolution involves:

1. Identifying the conflicting file.
2. Opening the file in an editor.
3. Reviewing both versions.
4. Choosing or combining the required changes.
5. Removing conflict markers.
6. Staging the corrected file.
7. Completing the merge commit.

## Git Branching Architecture

```text
                  Initial Commit
                        |
                        v
                      main
                        |
             +----------+----------+
             |                     |
             v                     v
         Main Change          Feature Branch
             |                     |
             v                     v
         Commit A              Commit B
             |                     |
             +----------+----------+
                        |
                        v
                  Merge Attempt
                        |
               +--------+--------+
               |                 |
               v                 v
         No Conflict         Conflict
               |                 |
               v                 v
         Auto Merge        Manual Resolution
               |                 |
               +--------+--------+
                        |
                        v
                   Merge Commit
                        |
                        v
                    GitHub
```

## Procedure

### Step 1: Check Git Installation

```bash
git --version
```

### Step 2: Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

Replace the placeholders with your Git identity.

### Step 3: Create a Repository

```bash
mkdir git-branching-demo
cd git-branching-demo
git init -b main
```

### Step 4: Create the Initial File

Create `main.py`:

```python
print("Welcome to DevOps Laboratory")
print("Application Version 1")
```

Stage and commit:

```bash
git add main.py
git commit -m "Initial commit"
```

### Step 5: Create a New Branch

```bash
git branch feature-update
git switch feature-update
```

Verify:

```bash
git branch
```

### Step 6: Modify the Feature Branch

Update `main.py`:

```python
print("Welcome to DevOps Laboratory")
print("Feature branch update")
```

Commit:

```bash
git add main.py
git commit -m "Update application in feature branch"
```

### Step 7: Merge the Feature Branch

```bash
git switch main
git merge feature-update
```

The feature changes are integrated into main.

### Step 8: Prepare a Merge Conflict

Create a new file named `message.txt`:

```text
Application Status: Initial
```

Commit it on main:

```bash
git add message.txt
git commit -m "Add initial status"
```

Create a conflict demonstration branch:

```bash
git switch -c conflict-demo
```

Change `message.txt` to:

```text
Application Status: Updated by feature branch
```

Commit:

```bash
git add message.txt
git commit -m "Update status on feature branch"
```

### Step 9: Make a Conflicting Change on Main

```bash
git switch main
```

Change the same line in `message.txt` to:

```text
Application Status: Updated by main branch
```

Commit:

```bash
git add message.txt
git commit -m "Update status on main branch"
```

### Step 10: Trigger the Conflict

Run:

```bash
git merge conflict-demo
```

Git should report a merge conflict.

### Step 11: Examine Conflict Markers

Open `message.txt`.

It will contain markers similar to:

```text
<<<<<<< HEAD
Application Status: Updated by main branch
=======
Application Status: Updated by feature branch
>>>>>>> conflict-demo
```

The HEAD section represents the current branch.

The other section represents the incoming branch.

### Step 12: Resolve the Conflict

Replace the conflicting content with:

```text
Application Status: Updated by main and feature branches
```

Stage and commit:

```bash
git add message.txt
git commit -m "Resolve merge conflict"
```

### Step 13: Verify the Repository

```bash
git status
git branch
git log --oneline --graph --all
```

The repository should have a clean working tree and a completed merge history.

### Step 14: Push to GitHub

Create an empty GitHub repository named `git-branching-demo`.

Connect the local repository:

```bash
git remote add origin https://github.com/YOUR_USERNAME/git-branching-demo.git
```

Push the main branch:

```bash
git push -u origin main
```

Push the demonstration branches if required:

```bash
git push -u origin feature-update
git push -u origin conflict-demo
```

Replace `YOUR_USERNAME` with your GitHub username.

## Important Git Commands

| Command | Description |
|---------|-------------|
| git init | Initialize a repository |
| git branch | List or create branches |
| git switch | Switch between branches |
| git switch -c | Create and switch to a branch |
| git add | Stage changes |
| git commit | Record changes |
| git merge | Merge branches |
| git status | Display repository status |
| git diff | Compare changes |
| git log | View commit history |
| git push | Upload commits to GitHub |
| git pull | Download and integrate remote changes |

## Expected Output

1. Repository initialized successfully.
2. Feature branch created.
3. Changes committed independently.
4. Feature branch merged into main.
5. Merge conflict generated intentionally.
6. Conflict markers displayed.
7. Conflict resolved manually.
8. Final merge commit created.
9. Repository history verified.
10. Changes pushed to GitHub when configured.

## Applications

- Collaborative software development
- Feature development
- Bug fixing
- Release management
- Code integration
- GitHub-based teamwork
- DevOps CI/CD workflows

## Result

Git branching, merging, and merge conflict resolution operations are demonstrated successfully when the commands complete as expected.

## Conclusion

This experiment explains how Git branches allow parallel software development.

It demonstrates how independent changes are merged and how conflicting modifications can be resolved manually.

These operations are essential for version management and collaborative DevOps development.
