from hashlib import md5
from api.v1 import auth, db


@auth.get_password
def get_password(username):
    return db.fetch_one("""
        SELECT * FROM users_read_auth_info({login});
    """.format(login=username))['password']


@auth.hash_password
def hash_password(password):
    return md5(password).hexdigest()
