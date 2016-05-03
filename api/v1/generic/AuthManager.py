from hashlib import md5
from flask.ext.httpauth import HTTPBasicAuth
from helpers import db
from api.v1.exceptions.AuthRequired import AuthRequired


class AuthManager(HTTPBasicAuth):
    def __init__(self):
        super(AuthManager, self).__init__()
        self.error_handler(self.on_auth_error)

    def on_auth_error(self):
        raise AuthRequired

    @staticmethod
    def get_password_callback(username):
        return db.fetch_one("""
            SELECT * FROM users_read_auth_info({login});
        """.format(login=username))['password']

    @staticmethod
    def hash_password_callback(password):
        return md5(password).hexdigest()
