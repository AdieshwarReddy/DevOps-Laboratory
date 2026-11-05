
# Experiment 9: Monitoring Applications Using Prometheus and Grafana

## Aim

To monitor a Python Flask web application using Prometheus and Grafana by collecting HTTP request counts, request rates, error distributions, and response latency metrics.

## Objectives

1. Understand application performance monitoring.
2. Create a Flask web application.
3. Install and use the Prometheus Python client.
4. Instrument HTTP requests using Counters and Histograms.
5. Expose metrics through an HTTP /metrics endpoint.
6. Configure Prometheus scraping.
7. Run Prometheus and Grafana using Docker.
8. Connect Grafana to Prometheus.
9. Visualize RED metrics using PromQL.
10. Verify monitoring dashboards and application health.

## Requirements

- Windows 10/11 with Docker Desktop, Ubuntu Linux, or macOS
- Docker Engine / Docker Desktop
- Docker Compose
- Python 3.8 or later
- Flask
- prometheus-client
- Web browser
- Available ports: 5000, 9090, 3000

## Theory

### What is Monitoring?

Monitoring is the process of collecting and analyzing system and application metrics to evaluate performance, availability, and reliability.

### What is Prometheus?

Prometheus is an open-source monitoring and time-series database system.

It periodically collects metrics from configured targets using HTTP requests.

### What is Grafana?

Grafana is an observability platform used to create dashboards and visualize metrics collected from data sources such as Prometheus.

### What is Application Instrumentation?

Instrumentation adds code that records application behavior, including request counts, errors, and processing time.

### What is a Counter?

A Counter is a metric that increases over time.

Example:

```text
http_requests_total
```

### What is a Histogram?

A Histogram records the distribution of observed values.

It is useful for measuring HTTP request latency.

Example:

```text
http_request_duration_seconds
```

### What is PromQL?

PromQL is Prometheus Query Language.

It is used to retrieve and aggregate time-series metrics.

### What are RED Metrics?

RED is a monitoring method based on:

- Rate: Requests processed per second
- Errors: Failed requests or error rate
- Duration: Time required to process requests

## Monitoring Architecture

```text
                User / Browser
                      |
                      v
               Flask Application
                      |
          +-----------+-----------+
          |                       |
          v                       v
     HTTP Requests          /metrics
                                  |
                                  v
                            Prometheus
                           (Scrape Data)
                                  |
                                  v
                         Time-Series Storage
                                  |
                                  v
                               Grafana
                                  |
                                  v
                          Monitoring Dashboard
                                  |
                     +------------+------------+
                     |            |            |
                     v            v            v
                    Rate        Errors       Duration
```

## Algorithm

1. Create a Python Flask application.
2. Install Flask and prometheus-client.
3. Define Counter and Histogram metrics.
4. Record request status, method, and endpoint.
5. Expose metrics at /metrics.
6. Configure Prometheus scrape intervals and targets.
7. Start the Flask application.
8. Start Prometheus.
9. Start Grafana.
10. Configure the Prometheus data source.
11. Create RED monitoring dashboard panels.
12. Generate application traffic.
13. Verify request counts and latency metrics.
14. Inspect Prometheus target health.
15. Verify Grafana visualizations.

## Procedure

### Step 1: Verify Prerequisites

```bash
docker --version
docker compose version
python3 --version
```

### Step 2: Create Flask Application

Create `app.py`.

The application provides:

- `/` - Home endpoint
- `/health` - Health endpoint
- `/error` - Test error endpoint
- `/metrics` - Prometheus metrics endpoint

### Step 3: Install Python Dependencies

```bash
python3 -m pip install -r requirements.txt
```

For an externally managed Python environment, create and activate a virtual environment first.

### Step 4: Run Flask Locally

```bash
python3 app.py
```

Open:

```text
http://localhost:5000
```

### Step 5: Verify Metrics Endpoint

```text
http://localhost:5000/metrics
```

The endpoint returns Prometheus-compatible text metrics.

### Step 6: Configure Prometheus

Create `prometheus.yml`.

Set the scrape target to:

```text
flask-app:5000
```

This hostname works inside the Docker Compose network.

### Step 7: Start Monitoring Stack

```bash
docker compose up -d --build
```

The command starts:

- Flask application
- Prometheus
- Grafana

### Step 8: Verify Containers

```bash
docker compose ps
```

### Step 9: Access Prometheus

Open:

```text
http://localhost:9090
```

Navigate to Status > Targets.

Verify that the Flask application target is UP.

### Step 10: Access Grafana

Open:

```text
http://localhost:3000
```

Sign in with the configured administrator account.

Change any default or temporary administrator password.

### Step 11: Verify Data Source

The Grafana provisioning file configures Prometheus automatically.

Data source URL:

```text
http://prometheus:9090
```

This uses the Docker Compose service name.

### Step 12: Open Monitoring Dashboard

Navigate to:

Dashboards > DevOps Laboratory > DevOps Application Monitoring

The dashboard is automatically provisioned from the JSON file.

### Step 13: Generate Traffic

```bash
curl http://localhost:5000/
curl http://localhost:5000/health
curl http://localhost:5000/error
```

The /error endpoint intentionally returns HTTP 500 for testing.

### Step 14: Run PromQL Queries

Total requests:

```promql
sum(http_requests_total)
```

Requests per second:

```promql
sum(rate(http_requests_total[5m]))
```

Error distribution:

```promql
sum by (status) (rate(http_requests_total[5m]))
```

95th percentile latency:

```promql
histogram_quantile(
  0.95,
  sum by (le) (
    rate(http_request_duration_seconds_bucket[5m])
  )
)
```

### Step 15: Verify Metrics

Check:

- Total request count
- Request rate
- HTTP error distribution
- 95th percentile latency
- Prometheus target status

### Step 16: Stop Monitoring Stack

```bash
docker compose down
```

To remove stored monitoring data as well:

```bash
docker compose down -v
```

Use the second command only if the stored monitoring history is no longer needed.

## Important Commands

| Command | Purpose |
|---------|---------|
| docker compose up -d --build | Start monitoring stack |
| docker compose ps | List services |
| docker compose logs | View logs |
| docker compose down | Stop services |
| curl localhost:5000/metrics | Read metrics |
| curl localhost:9090/-/healthy | Check Prometheus |
| docker compose restart | Restart services |

## Expected Output

- Flask application running on port 5000.
- /metrics endpoint exposing Prometheus metrics.
- Prometheus running on port 9090.
- Flask scrape target reporting UP.
- Grafana running on port 3000.
- Prometheus data source configured.
- Dashboard displaying RED metrics.
- Traffic and error requests reflected in metrics.

## Applications

- Application performance monitoring
- Service reliability engineering
- Microservices observability
- Incident detection
- Capacity planning
- DevOps monitoring
- Performance troubleshooting

## Result

A Flask application is instrumented to expose Prometheus metrics, and a containerized monitoring stack is configured to collect and visualize application performance data.

## Conclusion

This experiment demonstrates the use of Prometheus and Grafana for application monitoring.

Counters, Histograms, PromQL, and Grafana dashboards provide visibility into request volume, error behavior, and application latency.
