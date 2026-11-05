

# Experiment 10: End-to-End DevOps Workflow Integration

## Aim

To implement an end-to-end DevOps workflow using Git, Jenkins, Docker, Kubernetes, Prometheus, and Grafana for automated application testing, container image creation, deployment, and monitoring.

## Objectives

1. Develop a Go web application.
2. Write and execute Go unit tests.
3. Manage application source code using Git.
4. Build a lightweight Docker image using multi-stage builds.
5. Create a Jenkins Declarative Pipeline.
6. Automate checkout, testing, image building, and publishing.
7. Tag Docker images using build numbers and Git commit hashes.
8. Deploy container images using Kubernetes.
9. Configure resource requests, limits, and health probes.
10. Expose the application through a Kubernetes Service.
11. Install Prometheus and Grafana using Helm.
12. Configure a ServiceMonitor for application metrics.
13. Verify the complete CI/CD and monitoring workflow.

## Requirements

- Linux, Windows with WSL2, or macOS
- Git
- Go 1.22 or compatible version
- Jenkins LTS
- Docker Engine / Docker Desktop
- Docker Hub account and repository
- Kubernetes cluster
- kubectl
- Helm
- Prometheus and Grafana
- Internet connection

Recommended hardware for the complete local stack:

- 4 CPU cores
- 8 GB RAM minimum
- 16 GB RAM recommended
- 40 GB available storage

## Theory

### What is an End-to-End DevOps Workflow?

An end-to-end DevOps workflow automates the process of developing, testing, packaging, deploying, and monitoring software.

### Role of Git

Git tracks application changes and provides a version-controlled source repository.

### Role of Jenkins

Jenkins automates build, test, container publishing, and deployment stages.

### Role of Docker

Docker packages the application into a portable container image.

### Role of Kubernetes

Kubernetes manages application replicas, networking, deployment updates, and recovery.

### Role of Prometheus

Prometheus collects application metrics from the /metrics endpoint.

### Role of Grafana

Grafana visualizes metrics using dashboards.

### Role of Helm

Helm is a Kubernetes package manager used to install complex applications such as Prometheus and Grafana.

### What is a ServiceMonitor?

A ServiceMonitor is a Kubernetes custom resource used by the Prometheus Operator to discover and scrape metrics from matching Services.

## Architecture

```text
                Developer
                    |
                    v
              Git Repository
                    |
                    v
             Jenkins Pipeline
                    |
        +-----------+-----------+
        |                       |
        v                       v
     Go Tests              Docker Build
                                |
                                v
                         Docker Hub
                                |
                                v
                         Kubernetes
                                |
                         Deployment
                                |
                    +-----------+-----------+
                    |           |           |
                    v           v           v
                  Pod 1       Pod 2       Pod 3
                    |           |           |
                    +-----------+-----------+
                                |
                                v
                         ClusterIP Service
                                |
                         /metrics endpoint
                                |
                                v
                         ServiceMonitor
                                |
                                v
                           Prometheus
                                |
                                v
                             Grafana
                                |
                                v
                       Monitoring Dashboard
```

## Pipeline Stages

| Stage | Action |
|-------|--------|
| Checkout | Retrieve Git source code |
| Test | Execute Go unit tests |
| Build & Tag | Create versioned Docker image |
| Push | Upload image to Docker Hub |
| Deploy | Apply Kubernetes manifests and update image |
| Verify | Confirm Kubernetes rollout |

## Procedure

### Step 1: Create the Go Application

Create:

- main.go
- main_test.go
- go.mod

The application exposes:

- / : Home endpoint
- /health : Health endpoint
- /metrics : Prometheus metrics endpoint

### Step 2: Test the Application

```bash
go test ./...
```

Run locally:

```bash
go run .
```

Open:

```text
http://localhost:8080
```

### Step 3: Create Multi-Stage Dockerfile

The Dockerfile contains:

1. Go builder stage
2. Minimal runtime stage

### Step 4: Build Docker Image

```bash
docker build -t devops-go-app:local .
```

### Step 5: Test Docker Container

```bash
docker run --rm -p 127.0.0.1:8080:8080 \
  devops-go-app:local
```

### Step 6: Push Source Code to GitHub

From the repository root:

```bash
git add Experiment-10-End-to-End-DevOps/
git commit -m "Add experiment 10 end-to-end DevOps workflow"
git push origin main
```

### Step 7: Prepare Docker Hub

Create a Docker Hub repository named:

```text
devops-go-app
```

The full image name will be:

```text
YOUR_DOCKERHUB_USERNAME/devops-go-app
```

### Step 8: Configure Jenkins Credentials

Create a Jenkins credential:

- Kind: Username with password
- ID: dockerhub-credentials
- Username: Docker Hub username
- Password: Docker Hub access token

Never store Docker Hub credentials in Git.

### Step 9: Configure Jenkins Agent

The Jenkins build agent must have:

- Git
- Go
- Docker CLI and authorized Docker daemon access
- kubectl
- Kubernetes credentials

The pipeline runs on a trusted agent labeled:

```text
devops-k8s
```

Configure that label on the agent before running the job.

### Step 10: Create Jenkins Pipeline

Create a Jenkins Pipeline job:

```text
End-to-End-DevOps
```

Set:

Definition: Pipeline script from SCM

SCM: Git

Branch: */main

Script Path:

```text
Experiment-10-End-to-End-DevOps/Jenkinsfile
```

Set the job parameter DOCKERHUB_USER to your Docker Hub username.

### Step 11: Prepare Kubernetes

Verify the cluster:

```bash
kubectl get nodes
```

Create the application namespace:

```bash
kubectl create namespace devops-lab
```

If it already exists, skip this command.

### Step 12: Deploy Application

The Jenkins pipeline will:

1. Apply the Kubernetes manifests.
2. Update the Deployment image to the newly published tag.
3. Wait for the rollout.
4. Verify Deployment and Service status.

### Step 13: Install Helm

Verify:

```bash
helm version
```

### Step 14: Install Monitoring Stack

Add the Helm repository:

```bash
helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts

helm repo update
```

Install monitoring:

```bash
helm upgrade --install monitoring \
  prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  -f monitoring/helm-values.yaml
```

### Step 15: Configure ServiceMonitor

After the monitoring stack is ready:

```bash
kubectl apply -f k8s/servicemonitor.yaml
```

### Step 16: Verify Monitoring

```bash
kubectl get servicemonitor -n devops-lab
kubectl get pods -n monitoring
```

### Step 17: Access Grafana

```bash
kubectl port-forward \
  -n monitoring \
  svc/monitoring-grafana \
  3000:80
```

Open:

```text
http://localhost:3000
```

Retrieve the administrator password securely from the Helm-managed Kubernetes Secret.

### Step 18: Verify Prometheus Metrics

Open Prometheus using port forwarding:

```bash
kubectl port-forward \
  -n monitoring \
  svc/monitoring-kube-prometheus-prometheus \
  9090:9090
```

Open:

```text
http://localhost:9090
```

Verify that the application metrics target is discovered and reporting UP.

### Step 19: Inspect Dashboard

Import the supplied Grafana dashboard JSON.

Verify:

- HTTP request rate
- Total HTTP requests
- Error rate
- Application availability

### Step 20: Verify End-to-End Result

Confirm:

- Git checkout completed.
- Go tests passed.
- Docker image built.
- Docker image pushed.
- Kubernetes Deployment updated.
- Application Pods running.
- Service accessible.
- Prometheus collecting metrics.
- Grafana visualizing metrics.

## Expected Output

1. Go unit tests pass.
2. Docker image builds successfully.
3. Jenkins pipeline finishes successfully.
4. Docker Hub contains the versioned image.
5. Kubernetes Deployment becomes Ready.
6. Application responds to HTTP requests.
7. ServiceMonitor is created.
8. Prometheus discovers application metrics.
9. Grafana displays application monitoring data.

## Result

An integrated DevOps workflow is demonstrated using Git, Jenkins, Docker, Kubernetes, Prometheus, and Grafana.

## Conclusion

This experiment demonstrates automated application testing, containerization, image publishing, Kubernetes deployment, and monitoring.

The integrated workflow improves consistency, deployment repeatability, and visibility into application behavior.
