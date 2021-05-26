#!/usr/bin/env python
from flask import Flask, request, jsonify
from os import environ
from pprint import pprint
import config
import datetime
import json
import logging
import platform

app = Flask(__name__)

# Set logging config
log = logging.getLogger("werkzeug")
log.disabled = True
app.logger.setLevel("INFO")


@app.route("/", methods=["GET"])
def root_endpoint():

    """Function for / endpoint"""

    app.logger.info(f"'/' endpoint was called")

    platform_info = platform.uname()

    # Return JSON formatted response object
    return jsonify(platform_info)


@app.route("/test1/", methods=["GET"])
def test1_endpoint():

    """Function for /test1 endpoint"""

    app.logger.info(f"'/test1' endpoint was called")

    test1_text = "Test1"

    # Return JSON formatted response object
    return jsonify(test1_text)

@app.route("/healthz/", methods=["GET"])
def healthz_endpoint():

    """Function for /healthz endpoint"""

    app.logger.info(f"'/healthz' endpoint was called")

    # This is for demonstration purposes only. You should use logic custom to
    # your app to provide an accurate source for its health

    health_response = {
        "pod_name": environ["POD_NAME"],
        "date_time": str(datetime.datetime.now()),
        "health": "ok",
    }

    # Return JSON formatted response object
    return jsonify(health_response)

@app.route("/readyz/", methods=["GET"])
def readyz_endpoint():

    """Function for /readyz endpoint"""

    app.logger.info(f"'/readyz' endpoint was called")

    # This is for demonstration purposes only. You should use logic custom to
    # your app to provide an accurate source for its readiness

    health_response = {
        "pod_name": environ["POD_NAME"],
        "date_time": str(datetime.datetime.now()),
        "health": "ready",
    }

    # Return JSON formatted response object
    return jsonify(health_response)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=config.APP_PORT, debug=config.APP_DEBUG)
