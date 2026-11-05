
#!/usr/bin/env bash

# Experiment 7: Docker Image and Container Management
# Run from the Experiment 7 directory

set -euo pipefail

PYTHON_IMAGE="python-docker-app:v1"
FLASK_IMAGE="flask-docker-app:v1"

PYTHON_CONTAINER="exp7-python-demo"
FLASK_CONTAINER="exp7-flask-demo"

echo "========================================"
echo "EXPERIMENT 7: DOCKER MANAGEMENT"
echo "========================================"

# Check Docker
if ! command -v docker >/dev/null 2>&1; then
    echo "Error: Docker is not installed."
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker Engine is not running."
    exit 1
fi

# Avoid modifying existing containers
for name in "$PYTHON_CONTAINER" "$FLASK_CONTAINER"; do
    if docker container inspect "$name" \
        >/dev/null 2>&1; then
        echo "Error: Container $name already exists."
        echo "Remove it manually before rerunning."
        exit 1
    fi
done

echo ""
echo "STEP 1: Docker Version"
docker --version

echo ""
echo "STEP 2: Building Python image"
docker build -t "$PYTHON_IMAGE" .

echo ""
echo "STEP 3: Running Python container"
docker run --name "$PYTHON_CONTAINER" \
    "$PYTHON_IMAGE"

echo ""
echo "STEP 4: Python container logs"
docker logs "$PYTHON_CONTAINER"

echo ""
echo "STEP 5: Building Flask image"
docker build -f Dockerfile.flask \
    -t "$FLASK_IMAGE" .

echo ""
echo "STEP 6: Starting Flask container"
docker run -d \
    --name "$FLASK_CONTAINER" \
    -p 127.0.0.1:5000:5000 \
    "$FLASK_IMAGE"

echo ""
echo "STEP 7: Checking running containers"
docker ps --filter "name=$FLASK_CONTAINER"

echo ""
echo "STEP 8: Testing Flask application"

if command -v curl >/dev/null 2>&1; then
    ready=0

    for attempt in 1 2 3 4 5 6 7 8 9 10; do
        if curl -fsS http://127.0.0.1:5000/; then
            ready=1
            break
        fi
        sleep 1
    done

    if [ "$ready" -ne 1 ]; then
        echo "Flask application did not become ready."
        docker logs "$FLASK_CONTAINER"
        exit 1
    fi
else
    echo "curl unavailable; verify in a browser."
fi

echo ""
echo ""
echo "STEP 9: Stopping Flask container"
docker stop "$FLASK_CONTAINER"

echo ""
echo "STEP 10: Starting Flask container"
docker start "$FLASK_CONTAINER"

echo ""
echo "STEP 11: Restarting Flask container"
docker restart "$FLASK_CONTAINER"

echo ""
echo "STEP 12: Container logs"
docker logs "$FLASK_CONTAINER"

echo ""
echo "STEP 13: Container inspection"
docker inspect \
    --format '{{.Name}} | {{.State.Status}}' \
    "$FLASK_CONTAINER"

echo ""
echo "STEP 14: Available Docker images"
docker images \
    --filter "reference=python-docker-app:v1"

docker images \
    --filter "reference=flask-docker-app:v1"

echo ""
echo "STEP 15: Container cleanup"

docker stop "$FLASK_CONTAINER"
docker rm "$FLASK_CONTAINER"
docker rm "$PYTHON_CONTAINER"

echo ""
echo "STEP 16: Image cleanup"

if [ "${REMOVE_IMAGES:-no}" = "yes" ]; then
    docker rmi "$FLASK_IMAGE"
    docker rmi "$PYTHON_IMAGE"
else
    echo "Images retained for later use."
    echo "Set REMOVE_IMAGES=yes to remove them."
fi

echo ""
echo "========================================"
echo "DOCKER EXPERIMENT COMPLETED"
echo "========================================"
