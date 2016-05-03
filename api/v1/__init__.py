from flask.ext.httpauth import HTTPBasicAuth
from helpers import db, config, check_set
from api.v1.App import App
from api.v1.exceptions.BadStructure import BadStructure

__version__ = '1.0'

app = App(__name__)
auth = HTTPBasicAuth()


# Import entities
from api.v1 import authentication, user, users, tags
