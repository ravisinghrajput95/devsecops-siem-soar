from flask import Flask, jsonify, request
import logging
import os

app = Flask(__name__)

log_path = os.environ.get("APP_LOG_PATH", "/var/log/app.log")
logging.basicConfig(
    filename=log_path,
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s"
)
logger = logging.getLogger(__name__)

@app.route("/")
def home():
    logger.info("Homepage accessed")
    return {"message": "Welcome to DevSecOps SIEM-SOAR App"}, 200

@app.route("/login", methods=["POST"])
def login():
    data = request.json or {}
    username = data.get("username")
    logger.info(f"Login attempt by {username}")
    if username == "admin":
        return {"status": "success"}, 200
    return {"status": "unauthorized"}, 401

@app.route("/health")
def health():
    return {"status": "ok"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
