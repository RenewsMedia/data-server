import atexit
import helpers
from api.v1 import app

app.run()


def on_exit():
    helpers.db.close()

atexit.register(on_exit)
