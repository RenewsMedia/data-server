from flask import Flask, jsonify
from helpers import db, config, check_set
from api.v1.exceptions.BadStructure import BadStructure

__version__ = '1.0'

app = Flask(__name__)
app.config['SERVER_NAME'] = config['server']['host']


def make_path(path):
    return '/api/v1' + path


# Import entities
import api.v1.user


# Error handlers
@app.errorhandler(Exception)
def on_error(e):
    response = jsonify(e.to_dict())
    response.status_code = e.status_code
    return response
