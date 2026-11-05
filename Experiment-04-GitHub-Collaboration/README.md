
# Experiment 4: Repository Collaboration Using Pull Requests and Code Reviews

## Aim

To implement repository collaboration using Git and GitHub in an AWS EC2-based DevOps environment through feature branching, pull requests, code review, approval, and merging.

## Objectives

1. Understand collaborative development using Git and GitHub.
2. Configure Linux development environments on AWS EC2.
3. Clone a shared GitHub repository.
4. Create and manage feature branches.
5. Commit and push changes to GitHub.
6. Create pull requests.
7. Review code and provide feedback.
8. Modify code based on review comments.
9. Approve and merge pull requests.
10. Synchronize updated code across development environments.

## Requirements

- AWS account
- Two Linux EC2 instances (recommended)
- GitHub account
- Git
- Python 3
- SSH terminal
- Internet connection
- VS Code or another text editor (optional)

## Theory

### What is Repository Collaboration?

Repository collaboration allows multiple developers to work on the same software project while maintaining a shared version history.

Git supports local development, while GitHub provides remote repository hosting and collaboration tools.

### What is a Feature Branch?

A feature branch is an independent development branch created to implement a new feature or fix a bug.

It keeps unfinished changes separate from the stable main branch.

### What is a Pull Request?

A pull request (PR) is a GitHub feature used to propose merging changes from one branch into another.

A pull request allows other developers to inspect, discuss, test, and approve changes before merging.

### What is Code Review?

Code review is the process of examining source-code changes to identify errors, improve readability, and maintain coding standards.

Common review actions include:

- Comment
- Approve
- Request changes

### What is AWS EC2?

Amazon Elastic Compute Cloud (EC2) provides virtual servers in the cloud.

In this experiment, two Linux development environments represent separate developers collaborating through GitHub.

## Architecture

```text
       AWS EC2 - Developer 1
                 |
                 | git clone
                 v
          Local Repository
                 |
           Feature Branch
                 |
            git commit
                 |
             git push
                 |
                 v
        GitHub Remote Repository
                 |
                 v
            Pull Request
                 |
                 v
          Code Review Process
                 |
        +--------+---------+
        |                  |
        v                  v
    Approved         Changes Requested
        |                  |
        |             Update Code
        |                  |
        |             Push Commits
        |                  |
        +--------<---------+
                 |
                 v
           Merge into main
                 |
                 v
       AWS EC2 - Developer 2
                 |
             git pull
                 |
                 v
          Updated Codebase
```

## Procedure

### Step 1: Launch AWS EC2 Instances

1. Sign in to the AWS Management Console.
2. Open the EC2 dashboard.
3. Launch two Ubuntu Linux instances.
4. Configure SSH access using an EC2 key pair.
5. Allow inbound SSH only from trusted IP addresses.
6. Start both instances.

Use instance names such as:

- DevOps-Developer-1
- DevOps-Developer-2

### Step 2: Connect to EC2

Example:

```bash
ssh -i your-key.pem ubuntu@EC2_PUBLIC_IP
```

Replace the placeholders with your own key path and instance address.

### Step 3: Install Git and Python

Run on both instances:

```bash
sudo apt update
sudo apt install -y git python3
```

Verify:

```bash
git --version
python3 --version
```

### Step 4: Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

### Step 5: Create a GitHub Repository

Create a repository named:

`devops-collaboration-demo`

Initialize it with a README file.

### Step 6: Clone the Repository

On Developer 1's instance:

```bash
git clone https://github.com/YOUR_USERNAME/devops-collaboration-demo.git
cd devops-collaboration-demo
```

### Step 7: Create a Feature Branch

```bash
git switch -c feature-greeting
```

### Step 8: Create the Application

Create `main.py`:

```python
def greet(name):
    return f"Hello, {name}! Welcome to DevOps."

if __name__ == "__main__":
    print(greet("Student"))
```

Create `test_main.py`:

```python
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
```

### Step 9: Commit Changes

```bash
git add main.py test_main.py
git commit -m "Add greeting application and unit test"
```

### Step 10: Push the Feature Branch

```bash
git push -u origin feature-greeting
```

Authenticate with GitHub using an approved method.

### Step 11: Create a Pull Request

1. Open the repository on GitHub.
2. Select Compare & pull request.
3. Set the base branch to `main`.
4. Set the compare branch to `feature-greeting`.
5. Enter a descriptive title.
6. Explain the changes.
7. Click Create pull request.

Suggested title:

`Add greeting application with unit tests`

### Step 12: Perform Code Review

The reviewer opens the pull request and selects Files changed.

The reviewer examines:

- Code correctness
- Readability
- Naming conventions
- Test coverage
- Security concerns

The reviewer may leave comments or request changes.

### Step 13: Address Review Feedback

For example, improve the greeting function by removing unnecessary whitespace from names:

```python
def greet(name):
    clean_name = name.strip()
    return f"Hello, {clean_name}! Welcome to DevOps."
```

Update the unit test accordingly.

Commit and push:

```bash
git add main.py test_main.py
git commit -m "Improve greeting validation after review"
git push origin feature-greeting
```

The existing pull request updates automatically.

### Step 14: Approve and Merge

After the reviewer verifies the changes:

1. Select Review changes.
2. Choose Approve.
3. Submit the review.
4. Merge the pull request when permitted.
5. Confirm that the main branch contains the changes.

For a meaningful peer-review demonstration, use a separate GitHub reviewer account with repository access.

### Step 15: Synchronize Developer 2

On the second EC2 instance:

```bash
git clone https://github.com/YOUR_USERNAME/devops-collaboration-demo.git
cd devops-collaboration-demo
```

If the repository is already cloned:

```bash
git switch main
git pull origin main
```

### Step 16: Verify the Application

```bash
python3 main.py
python3 -m unittest -v
```

### Step 17: Verify Git History

```bash
git log --oneline --graph --all
git status
```

## Important Git Commands

| Command | Description |
|---------|-------------|
| git clone | Clone a remote repository |
| git switch -c | Create and switch to a new branch |
| git status | Check file changes |
| git add | Stage changes |
| git commit | Save changes |
| git push | Upload commits |
| git pull | Synchronize changes |
| git log | View commit history |
| git diff | Compare file changes |
| git branch | Display branches |

## Expected Output

- Two development environments configured.
- GitHub repository cloned.
- Feature branch created.
- Application changes committed and pushed.
- Pull request created.
- Code review performed.
- Review feedback addressed.
- Pull request approved and merged.
- Updated code synchronized between developers.
- Python application and unit tests executed.

## Applications

- Collaborative software development
- Open-source contributions
- Team-based DevOps workflows
- Peer code review
- Quality assurance
- Continuous Integration
- Software release management

## Result

Repository collaboration is demonstrated using Git, GitHub, feature branches, pull requests, code reviews, and merging.

## Conclusion

This experiment demonstrates a collaborative DevOps development workflow using GitHub and AWS EC2.

Pull requests and code reviews improve code quality, while Git branches and remote synchronization support organized teamwork.
