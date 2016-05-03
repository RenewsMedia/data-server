from hashlib import md5
from flask import request
from api.v1 import app, db, make_path, check_set, user
from api.v1.exceptions.BadStructure import BadStructure


def sign_in(login, password):
    usr = db.fetch_one("""
        SELECT * FROM users_read_auth_info({user_login}) LIMIT 1
    """.format(user_login=login))

    if usr and usr['password'] == md5(password).hexdigest():
        response = app.make_response(True)
        response.set_cookie('__uid', login)
        response.set_cookie('__ups', usr['password'])

    return False


@app.route(make_path('/sign/in'), methods=['POST'])
def sign_in_from_json():
    if not request.json or not check_set(['password'], request.json):
        raise BadStructure
    return sign_in(**request.json)


@app.route(make_path('/sign/up'), methods=['POST'])
def sign_up():
    if not request.json:
        raise BadStructure

    usr = user.create(request.json)
    if len(usr):
        return sign_in(usr['login'], request.json['password'])

    return False
