
# Experiment 7: Docker Image Creation and Container Management

## Aim

To create Docker images using Dockerfiles, build and execute containers, deploy a simple Flask web application, and perform Docker container management operations.

## Objectives

1. Understand Docker images and containers.
2. Verify Docker installation.
3. Create a simple Python application.
4. Write a Dockerfile.
5. Build a Docker image.
6. Run containers from images.
7. Create a Flask web application.
8. Map container ports to host ports.
9. List running and stopped containers.
10. Stop, start, and restart containers.
11. Inspect container logs and configuration.
12. Remove containers and unused images.

## Requirements

- Windows 10/11, Ubuntu Linux, or macOS
- Docker Desktop or Docker Engine
- Python 3 (optional for local execution)
- Code editor
- Terminal
- Web browser
- Internet connection

## Theory

### What is Docker?

Docker is a containerization platform used to package applications and their dependencies into portable, isolated containers.

### What is a Docker Image?

A Docker image is a read-only template containing the application, runtime, libraries, and configuration needed to create containers.

### What is a Docker Container?

A Docker container is a runnable instance of a Docker image.

Containers share the host operating system kernel while providing process and filesystem isolation.

### What is a Dockerfile?

A Dockerfile is a text file containing instructions used to build a Docker image.

### What is Docker Hub?

Docker Hub is an online container image registry used to distribute Docker images.

### Docker Architecture

```text
             Developer
                 |
                 v
             Dockerfile
                 |
                 | docker build
                 v
             Docker Image
                 |
                 | docker run
                 v
          Docker Container
                 |
        +--------+--------+
        |                 |
        v                 v
   Python Script      Flask Server
                          |
                          v
                   Container Port
                        5000
                          |
                   Port Mapping
                          |
                          v
                    Host Port
                        5000
                          |
                          v
                     Browser
```

## Important Dockerfile Instructions

| Instruction | Purpose |
|-------------|---------|
| FROM | Select base image |
| WORKDIR | Set working directory |
| COPY | Copy files into image |
| RUN | Execute build-time commands |
| EXPOSE | Document application port |
| CMD | Set default container command |

## Procedure

### Part A: Verify Docker Installation

Check Docker:

```bash
docker --version
```

Verify Docker Engine:

```bash
docker info
```

Run the official test image:

```bash
docker run --rm hello-world
```

Expected message:

```text
Hello from Docker!
```

### Part B: Create a Python Application

Create `app.py`:

```python
print("Hello from Docker Container!")
print("Docker image and container management experiment")
```

### Part C: Create Dockerfile

Create a file named `Dockerfile`:

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY app.py .

CMD ["python", "app.py"]
```

### Part D: Build Docker Image

```bash
docker build -t python-docker-app:v1 .
```

List images:

```bash
docker images
```

### Part E: Run Python Container

```bash
docker run --name python-demo python-docker-app:v1
```

Expected output:

```text
Hello from Docker Container!
Docker image and container management experiment
```

Since the Python program finishes immediately, the container exits after printing its output.

Inspect all containers:

```bash
docker ps -a
```

View logs:

```bash
docker logs python-demo
```

Remove the completed container:

```bash
docker rm python-demo
```

### Part F: Create Flask Web Application

Create `flask_app.py`:

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Docker Flask Container!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

Create `requirements.txt`:

```text
Flask>=3.0,<4.0
```

Create `Dockerfile.flask`:

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY flask_app.py .

EXPOSE 5000

CMD ["python", "flask_app.py"]
```

### Part G: Build and Run Flask Container

Build:

```bash
docker build -f Dockerfile.flask -t flask-docker-app:v1 .
```

Run:

```bash
docker run -d \
  --name flask-container \
  -p 127.0.0.1:5000:5000 \
  flask-docker-app:v1
```

The host binding `127.0.0.1` keeps the demonstration web service accessible locally rather than exposing it to the entire network.

Check the running container:

```bash
docker ps
```

Open:

```text
http://localhost:5000
```

Expected browser output:

```text
Hello from Docker Flask Container!
```

### Part H: Manage Containers

Stop:

```bash
docker stop flask-container
```

Start:

```bash
docker start flask-container
```

Restart:

```bash
docker restart flask-container
```

View logs:

```bash
docker logs flask-container
```

Inspect configuration:

```bash
docker inspect flask-container
```

View processes:

```bash
docker top flask-container
```

Monitor resource usage:

```bash
docker stats flask-container
```

Press Ctrl+C to stop the statistics display.

### Part I: Remove Container and Image

Stop and remove:

```bash
docker stop flask-container
docker rm flask-container
```

Remove images:

```bash
docker rmi flask-docker-app:v1
docker rmi python-docker-app:v1
```

### Part J: Verify Cleanup

```bash
docker ps -a
docker images
```

Confirm that the demonstration containers and images have been removed.

## Important Docker Commands

| Command | Description |
|---------|-------------|
| docker --version | Check Docker version |
| docker info | Display Docker information |
| docker pull | Download image |
| docker build | Build image |
| docker images | List images |
| docker run | Create and run container |
| docker ps | List running containers |
| docker ps -a | List all containers |
| docker stop | Stop container |
| docker start | Start container |
| docker restart | Restart container |
| docker logs | View container logs |
| docker inspect | Inspect configuration |
| docker top | View processes |
| docker stats | View resource usage |
| docker rm | Remove container |
| docker rmi | Remove image |

## Expected Output

1. Docker installation verified.
2. Hello-world container executed.
3. Python image built.
4. Python container executed successfully.
5. Flask image built.
6. Flask container started.
7. Port 5000 mapped to localhost.
8. Web application accessible through a browser.
9. Container lifecycle operations performed.
10. Container logs and metadata inspected.
11. Demonstration containers and images removed.

## Applications

- Application containerization
- Microservices deployment
- CI/CD pipelines
- Development environment consistency
- Cloud deployment
- Software testing
- DevOps automation

## Result

Docker image creation, Python and Flask container execution, port mapping, and container management operations are demonstrated.

## Conclusion

This experiment demonstrates how Docker packages applications into portable images and executes them as isolated containers.

Docker provides consistent deployment environments and supports modern DevOps automation.
