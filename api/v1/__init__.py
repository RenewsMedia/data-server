from api.v1.generic.AuthManager import AuthManager
from api.v1.generic.App import App
from api.v1.exceptions.BadStructure import BadStructure

__version__ = '1.0'

app = App(__name__)
auth = AuthManager()


# Import entities
import api.v1.user_auth
import api.v1.user
import api.v1.users
import api.v1.tags
