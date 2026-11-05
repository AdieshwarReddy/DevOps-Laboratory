
# Experiment 5: Jenkins Installation and Configuration

## Aim

To install Jenkins, configure the Jenkins server, complete the initial setup, create an administrator user, and verify that Jenkins can execute automation jobs in a DevOps environment.

## Objectives

1. Understand the role of Jenkins in CI/CD.
2. Install Java and Jenkins on Ubuntu Linux.
3. Configure the official Jenkins package repository.
4. Start, stop, restart, and verify the Jenkins service.
5. Access the Jenkins web interface.
6. Complete the initial setup wizard.
7. Install recommended plugins.
8. Create an administrator account.
9. Create and execute a Freestyle job.
10. Verify the Jenkins console output.

## Requirements

- Ubuntu Linux 22.04/24.04 LTS
- 64-bit processor
- Minimum 2 GB RAM; 4 GB recommended
- At least 10 GB free storage
- Compatible Java runtime
- Jenkins Long-Term Support (LTS)
- Internet connection
- Web browser
- Administrator/sudo privileges

## Theory

### What is Jenkins?

Jenkins is an open-source, Java-based automation server used to automate software development tasks.

It is widely used for Continuous Integration and Continuous Delivery (CI/CD).

### What is Continuous Integration?

Continuous Integration (CI) is the practice of frequently integrating source-code changes into a shared repository.

Automated builds and tests help identify errors early.

### What is Continuous Delivery?

Continuous Delivery (CD) prepares software for release through automated build, test, and packaging processes.

Production deployment may still require manual approval.

### What is a Jenkins Freestyle Job?

A Freestyle job is a configurable Jenkins project that executes build steps, such as shell commands, scripts, or tests.

It is suitable for learning basic Jenkins automation.

### Jenkins Architecture

```text
             Developer
                 |
                 v
          GitHub Repository
                 |
                 v
         Jenkins Controller
                 |
        +--------+--------+
        |                 |
        v                 v
   Job Scheduler     Web Dashboard
        |
        v
    Build Executor
        |
        v
   Execute Shell Script
        |
        v
     Build Output
        |
        v
    Console Logs
```

In larger environments, build execution can be delegated to separate Jenkins agents.

## Algorithm

1. Start Ubuntu Linux.
2. Update the APT package index.
3. Install a compatible Java runtime.
4. Add the official Jenkins LTS repository.
5. Install Jenkins.
6. Enable and start the Jenkins service.
7. Verify service status and port 8080.
8. Retrieve the initial administrator password.
9. Open Jenkins in a browser.
10. Unlock Jenkins.
11. Install suggested plugins.
12. Create an administrator account.
13. Configure the Jenkins URL.
14. Create a Freestyle project.
15. Add a shell build step.
16. Run the job.
17. Verify the console output.

## Procedure

### Step 1: Update Ubuntu

Open the terminal:

```bash
sudo apt update
sudo apt upgrade -y
```

### Step 2: Install Java

Install a Java runtime supported by your Jenkins LTS release.

For a current Jenkins LTS installation using Java 21:

```bash
sudo apt install -y fontconfig openjdk-21-jre
```

Verify:

```bash
java -version
```

Note: Older Jenkins versions may support Java 17. Always use a Java version supported by the Jenkins release being installed.

### Step 3: Add Jenkins Repository

Install the required utilities:

```bash
sudo apt install -y wget ca-certificates
```

Download the official Jenkins LTS signing key:

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
```

Add the Jenkins repository:

```bash
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
```

### Step 4: Install Jenkins

```bash
sudo apt update
sudo apt install -y jenkins
```

### Step 5: Start Jenkins

```bash
sudo systemctl enable --now jenkins
```

### Step 6: Verify Jenkins

```bash
sudo systemctl status jenkins
```

Expected status:

```text
Active: active (running)
```

### Step 7: Check Jenkins Port

```bash
sudo ss -ltnp | grep ':8080'
```

Jenkins normally uses TCP port 8080.

### Step 8: Access Jenkins

Open a browser:

```text
http://localhost:8080
```

For a remote server, use its IP address or hostname and port 8080.

Restrict remote access to trusted networks. Do not expose an unconfigured Jenkins server publicly.

### Step 9: Unlock Jenkins

Retrieve the initial administrator password:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Copy the password into the Jenkins setup wizard.

Do not upload this password to GitHub or include it in screenshots.

### Step 10: Install Plugins

Select:

Install suggested plugins

Wait for installation to finish.

### Step 11: Create Administrator

Enter your preferred:

- Username
- Password
- Full name
- Email address

Complete the setup wizard.

### Step 12: Configure Jenkins URL

Confirm the Jenkins URL and finish the initial setup.

### Step 13: Create Freestyle Job

1. Open Jenkins Dashboard.
2. Click New Item.
3. Enter `DevOps-Experiment-05`.
4. Select Freestyle project.
5. Click OK.
6. Scroll to Build Steps.
7. Select Execute shell.
8. Paste the contents of `freestyle_build.sh`.
9. Save the project.

### Step 14: Execute Job

Click:

Build Now

Wait for the build to finish.

### Step 15: Verify Console Output

Open:

Build History > Build Number > Console Output

Check that the shell commands ran successfully.

Expected result:

```text
Finished: SUCCESS
```

### Step 16: Manage Jenkins Service

Stop Jenkins:

```bash
sudo systemctl stop jenkins
```

Start Jenkins:

```bash
sudo systemctl start jenkins
```

Restart Jenkins:

```bash
sudo systemctl restart jenkins
```

Check status:

```bash
sudo systemctl status jenkins
```

## Important Commands

| Command | Purpose |
|---------|---------|
| java -version | Verify Java |
| sudo apt install jenkins | Install Jenkins |
| systemctl start jenkins | Start Jenkins |
| systemctl stop jenkins | Stop Jenkins |
| systemctl restart jenkins | Restart Jenkins |
| systemctl status jenkins | Check service |
| systemctl enable jenkins | Enable startup |
| ss -ltnp | Check listening ports |
| journalctl -u jenkins | View service logs |

## Expected Output

- Java installed successfully.
- Jenkins package installed.
- Jenkins service active.
- Jenkins accessible on port 8080.
- Initial setup completed.
- Administrator account created.
- Suggested plugins installed.
- Freestyle job executed.
- Console output displays successful completion.

## Applications

- Continuous Integration
- Continuous Delivery
- Build Automation
- Automated Testing
- Release Management
- Software Deployment
- DevOps Workflow Automation

## Result

Jenkins installation, initial configuration, service verification, and Freestyle job execution are demonstrated.

## Conclusion

This experiment demonstrates how Jenkins can be installed and configured as an automation server.

Jenkins provides a foundation for implementing automated build, testing, and deployment workflows in DevOps.
