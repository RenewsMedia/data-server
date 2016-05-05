from api.v1.generic.App import App
from api.v1.exceptions.BadStructure import BadStructure

__version__ = '1.0'

app = App(__name__)

# Authentication manager
from api.v1.generic.AuthManager import AuthManager
auth = AuthManager()

# Import entities
import api.v1.sign
import api.v1.countries
import api.v1.user
import api.v1.users
import api.v1.channel
import api.v1.article
import api.v1.contents
import api.v1.tags
