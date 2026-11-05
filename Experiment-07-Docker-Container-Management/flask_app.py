
# DevOps Laboratory - Experiment 7
# Flask Application for Docker

from flask import Flask

app = Flask(__name__)


@app.route("/")
def home():
    return "Hello from Docker Flask Container!"


@app.route("/health")
def health():
    return {
        "status": "healthy",
        "experiment": 7,
        "service": "docker-flask-app"
    }


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000
    )
