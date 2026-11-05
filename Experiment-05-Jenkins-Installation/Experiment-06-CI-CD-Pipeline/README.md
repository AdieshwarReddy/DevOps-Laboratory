
# Experiment 6: Creation of Continuous Integration and Continuous Deployment Pipelines

## Aim

To create and execute a Jenkins-based CI/CD pipeline that automatically retrieves source code, builds and tests an application, and deploys the verified application to a local deployment directory.

## Objectives

1. Understand Continuous Integration and Continuous Deployment.
2. Create a Jenkins Declarative Pipeline.
3. Store pipeline configuration in a Jenkinsfile.
4. Integrate Jenkins with a Git repository.
5. Automate source-code checkout.
6. Automate application build verification.
7. Execute automated unit tests.
8. Deploy validated application files.
9. Monitor pipeline execution in Jenkins.
10. Verify console output and deployment results.

## Requirements

- Ubuntu Linux 22.04/24.04 LTS
- Jenkins LTS
- Compatible Java runtime
- Git
- Python 3
- Bash
- GitHub repository
- Jenkins Pipeline and Git plugins
- Web browser
- Internet connection

## Theory

### What is Continuous Integration?

Continuous Integration (CI) is the practice of frequently integrating source-code changes into a shared repository.

Automated builds and tests detect errors early.

### What is Continuous Delivery?

Continuous Delivery ensures that an application remains ready for deployment after successful automated verification.

Production release may require manual approval.

### What is Continuous Deployment?

Continuous Deployment automatically deploys validated changes to a target environment without a separate manual release step.

### What is Jenkins?

Jenkins is an open-source automation server used to build, test, and deploy software.

### What is a Jenkins Pipeline?

A Jenkins Pipeline defines automated tasks as code.

A pipeline can contain multiple stages that execute in a specified sequence.

### What is a Jenkinsfile?

A Jenkinsfile is a text file containing the Jenkins Pipeline definition.

It is stored in version control alongside the application.

## CI/CD Architecture

```text
           Developer
               |
               v
        GitHub Repository
               |
               v
         Jenkins Pipeline
               |
               v
        +---------------+
        |   Checkout    |
        +---------------+
               |
               v
        +---------------+
        |     Build     |
        +---------------+
               |
               v
        +---------------+
        |     Test      |
        +---------------+
               |
          Tests Passed?
          /          \
        No            Yes
        |              |
        v              v
   Pipeline Fail  +---------------+
                  |    Deploy     |
                  +---------------+
                         |
                         v
                 Deployment Folder
                         |
                         v
                    SUCCESS
```

## Algorithm

1. Start Jenkins.
2. Create a Git repository containing the application.
3. Add the Jenkinsfile.
4. Configure a Jenkins Pipeline job.
5. Connect Jenkins to the Git repository.
6. Trigger the pipeline.
7. Check out the source code.
8. Execute build verification.
9. Run automated tests.
10. Stop the pipeline if tests fail.
11. Deploy verified files if tests pass.
12. Verify deployment output.
13. Inspect Jenkins Console Output.

## Procedure

### Step 1: Verify Jenkins

```bash
sudo systemctl status jenkins
```

Open Jenkins in a browser:

```text
http://localhost:8080
```

### Step 2: Verify Git and Python

```bash
git --version
python3 --version
```

### Step 3: Create the Application

Create `app.py`:

```python
def add(a, b):
    return a + b

def main():
    print("Welcome to DevOps CI/CD Pipeline")
    print("Addition Result:", add(10, 20))

if __name__ == "__main__":
    main()
```

### Step 4: Create Unit Tests

Create `test_app.py`:

```python
import unittest
from app import add

class TestApplication(unittest.TestCase):
    def test_addition(self):
        self.assertEqual(add(10, 20), 30)

    def test_negative_numbers(self):
        self.assertEqual(add(-5, 3), -2)

if __name__ == "__main__":
    unittest.main()
```

### Step 5: Create the Jenkinsfile

Create a Declarative Pipeline with:

- Checkout
- Build
- Test
- Deploy

Use the complete Jenkinsfile provided in this experiment folder.

### Step 6: Add Build and Deployment Scripts

Create:

- `build.sh`
- `deploy.sh`

The build script validates Python syntax and executes the application.

The deployment script copies the verified application to the deployment directory.

### Step 7: Commit and Push to GitHub

From the root of the DevOps-Laboratory repository:

```bash
git add Experiment-06-CI-CD-Pipeline/
git commit -m "Add experiment 6 CI/CD pipeline"
git push origin main
```

### Step 8: Create Jenkins Pipeline Job

1. Open Jenkins Dashboard.
2. Select New Item.
3. Enter `CI-CD-Pipeline`.
4. Select Pipeline.
5. Click OK.
6. Scroll to the Pipeline section.
7. Set Definition to `Pipeline script from SCM`.
8. Set SCM to Git.
9. Enter the GitHub repository URL.
10. Select credentials if required.
11. Set Branch Specifier to `*/main`.
12. Set Script Path to:

```text
Experiment-06-CI-CD-Pipeline/Jenkinsfile
```

13. Click Save.

The script path is relative to the repository root.

### Step 9: Run the Pipeline

Click:

Build Now

Monitor the stages in Jenkins.

### Step 10: Verify Console Output

Open:

Build History > Build Number > Console Output

Confirm that Checkout, Build, Test, and Deploy completed successfully.

### Step 11: Verify Deployment

The pipeline creates the deployment folder within the Jenkins workspace:

```text
Experiment-06-CI-CD-Pipeline/deployment/
```

The folder should contain:

```text
app.py
```

Run the deployed application:

```bash
python3 deployment/app.py
```

Expected output:

```text
Welcome to DevOps CI/CD Pipeline
Addition Result: 30
```

### Step 12: Confirm Pipeline Result

The Jenkins console should finish with:

```text
Finished: SUCCESS
```

## Pipeline Stages

| Stage | Purpose |
|-------|---------|
| Checkout | Retrieve code from Git |
| Build | Validate and execute application |
| Test | Run automated unit tests |
| Deploy | Copy validated application |
| Post | Report final pipeline status |

## Expected Output

- Source code retrieved successfully.
- Python syntax validated.
- Application executed.
- Unit tests passed.
- Deployment directory created.
- Application copied to deployment directory.
- Jenkins build completed successfully.

## Applications

- Automated software integration
- Automated testing
- Continuous Delivery
- Continuous Deployment
- Build automation
- Release management
- DevOps workflow automation

## Result

A Jenkins-based CI/CD pipeline is demonstrated using Git checkout, build verification, automated testing, and local deployment.

## Conclusion

This experiment demonstrates how Jenkins automates the software delivery lifecycle.

The pipeline improves consistency by validating source code and executing tests before deployment.

It provides a foundation for advanced DevOps pipelines using Docker, Kubernetes, and cloud platforms.
