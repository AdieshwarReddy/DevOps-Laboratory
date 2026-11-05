
#!/usr/bin/env bash

# Experiment 9: Prometheus and Grafana Monitoring

set -euo pipefail

echo "========================================"
echo "EXPERIMENT 9: APPLICATION MONITORING"
echo "========================================"

for tool in docker curl; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Error: $tool is required."
        exit 1
    fi
done

if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker Engine is not running."
    exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
    echo "Error: Docker Compose is required."
    exit 1
fi

if [ -z "${GRAFANA_ADMIN_PASSWORD:-}" ]; then
    echo "Set GRAFANA_ADMIN_PASSWORD first."
    exit 1
fi

echo ""
echo "STEP 1: Validate Docker Compose"
docker compose config --quiet

echo ""
echo "STEP 2: Start monitoring services"
docker compose up -d --build

echo ""
echo "STEP 3: Wait for Flask application"

ready=0
for attempt in $(seq 1 30); do
    if curl -fsS \
        http://127.0.0.1:5000/health \
        >/dev/null; then
        ready=1
        break
    fi
    sleep 2
done

if [ "$ready" -ne 1 ]; then
    echo "Flask did not become ready."
    docker compose logs flask-app
    exit 1
fi

echo "Flask application is responding."

echo ""
echo "STEP 4: Generate application traffic"

for i in $(seq 1 20); do
    curl -fsS http://127.0.0.1:5000/ \
        >/dev/null
done

for i in $(seq 1 5); do
    curl -s -o /dev/null \
        http://127.0.0.1:5000/error
done

echo "Generated 20 successful requests."
echo "Generated 5 simulated error requests."

echo ""
echo "STEP 5: Verify Prometheus metrics"

curl -fsS http://127.0.0.1:5000/metrics \
    | grep -E '^http_requests_total|^http_request_duration_seconds_count' \
    | head -n 15

echo ""
echo "STEP 6: Check Prometheus"

curl -fsS \
    http://127.0.0.1:9090/-/healthy

echo ""
echo "STEP 7: Check Grafana"

curl -fsS \
    http://127.0.0.1:3000/api/health

echo ""
echo "STEP 8: Container status"
docker compose ps

echo ""
echo "========================================"
echo "MONITORING SETUP CHECK COMPLETED"
echo "========================================"

echo "Flask:      http://localhost:5000"
echo "Prometheus: http://localhost:9090"
echo "Grafana:    http://localhost:3000"
echo "Check Prometheus Targets and Grafana panels."
