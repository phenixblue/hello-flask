#!/usr/bin/env python
from flask import Flask, request, jsonify
from os import environ
from pprint import pprint
import config
import json

app = Flask(__name__)


@app.route("/", methods=["GET"])
def root_endpoint():

    hello_text = "Hello, World!"

    return jsonify(hello_text)


@app.route("/test1/", methods=["GET"])
def test1_endpoint():

    test1_text = "Test1"

    return jsonify(test1_text)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=config.APP_PORT, debug=config.APP_DEBUG)
