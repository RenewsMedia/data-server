from flask import Flask
from helpers import db, config

__version__ = '1.0'

app = Flask(__name__)
app.config['SERVER_NAME'] = config['server']['host']


def make_path(path):
    return '/api/v1' + path


import api.v1.user