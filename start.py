import atexit
import helpers
from api.v1 import app


def on_exit():
    helpers.db.close()

atexit.register(on_exit)
app.run()
