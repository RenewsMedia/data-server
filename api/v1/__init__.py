from flask import Flask, jsonify
from flask.ext.httpauth import HTTPBasicAuth
from helpers import db, config, check_set
from api.v1.exceptions.BadStructure import BadStructure

__version__ = '1.0'

app = Flask(__name__)
app.config['SERVER_NAME'] = config['server']['host']
auth = HTTPBasicAuth()


def make_path(path):
    return '/api/v1' + path


# List to sql array
def list_to_sql(c_list):
    result = ''
    for v in c_list:
        result += '"' + v + '"'
    return '{' + result + '}'


# Response generator
def gen_resp(params, status_code=200):
    response = jsonify(params)
    response.status_code = status_code
    return response


# Error handlers
@app.errorhandler(Exception)
def on_error(e):
    return gen_resp(e.to_dict(), e.status_code)


# Import entities
import api.v1.authentication
import api.v1.user
import api.v1.users
import api.v1.tags
