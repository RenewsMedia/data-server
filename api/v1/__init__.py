from flask.ext.httpauth import HTTPBasicAuth
from api.v1.App import App
from api.v1.exceptions.BadStructure import BadStructure

__version__ = '1.0'

app = App(__name__)
auth = HTTPBasicAuth()


# Import entities
import api.v1.authentication
import api.v1.user
import api.v1.users
import api.v1.tags
