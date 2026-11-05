
from flask import Flask, Response, request
from prometheus_client import (
    Counter,
    Histogram,
    generate_latest,
    CONTENT_TYPE_LATEST
)
from time import perf_counter

app = Flask(__name__)

REQUEST_COUNT = Counter(
    "http_requests_total",
    "Total number of HTTP requests",
    ["method", "endpoint", "status"]
)

REQUEST_LATENCY = Histogram(
    "http_request_duration_seconds",
    "HTTP request latency in seconds",
    ["endpoint"],
    buckets=(0.005, 0.01, 0.025, 0.05,
             0.1, 0.25, 0.5, 1.0, 2.5, 5.0)
)


@app.before_request
def before_request():
    if request.path != "/metrics":
        request._start_time = perf_counter()


@app.after_request
def after_request(response):
    if request.path == "/metrics":
        return response

    endpoint = request.path
    elapsed = perf_counter() - getattr(
        request, "_start_time", perf_counter()
    )

    REQUEST_COUNT.labels(
        method=request.method,
        endpoint=endpoint,
        status=str(response.status_code)
    ).inc()

    REQUEST_LATENCY.labels(
        endpoint=endpoint
    ).observe(elapsed)

    return response


@app.route("/")
def home():
    return (
        "<h1>DevOps Laboratory - Experiment 9</h1>"
        "<p>Flask Monitoring Application</p>"
        "<p>Prometheus and Grafana Integration</p>"
    )


@app.route("/health")
def health():
    return {
        "status": "healthy",
        "experiment": 9
    }


@app.route("/error")
def test_error():
    return {"error": "Simulated server error"}, 500


@app.route("/metrics")
def metrics():
    return Response(
        generate_latest(),
        mimetype=CONTENT_TYPE_LATEST
    )


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000
    )
