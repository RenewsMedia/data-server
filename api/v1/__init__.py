from api.v1.generic.App import App
from api.v1.exceptions.BadStructure import BadStructure

__version__ = '1.0'

app = App(__name__)

# Authentication manager
from api.v1.generic.AuthManager import AuthManager
auth = AuthManager()

# Import entities
import api.v1.entities.sign
import api.v1.entities.countries
import api.v1.entities.user
import api.v1.entities.users
import api.v1.entities.channel
import api.v1.entities.article
import api.v1.entities.contents
import api.v1.entities.tags
