from hashlib import md5
from flask.ext.httpauth import HTTPBasicAuth
from helpers import db
from api.v1 import app
from api.v1.exceptions.AuthRequired import AuthRequired


class AuthManager(HTTPBasicAuth):
    def __init__(self):
        super(AuthManager, self).__init__()
        self.error_handler(self.on_auth_error)

    @staticmethod
    def on_auth_error(self):
        raise AuthRequired

    @staticmethod
    def verify_password_callback(uid, password):
        app.user = db.fetch_one("""
            SELECT * FROM "users" WHERE "id" = {uid} AND "password" = {password}
        """.format(uid=uid, password=password))

        if app.user:
            return True
        return False

    @staticmethod
    def get_password_callback(uid):
        return db.fetch_one("""
            SELECT "password" FROM "users" WHERE "id" = {uid};
        """.format(uid=uid))['password']

    @staticmethod
    def hash_password_callback(password):
        return md5(password).hexdigest()
