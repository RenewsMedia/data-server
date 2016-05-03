from hashlib import md5
from flask import request
from helpers import db, config, check_set
from api.v1 import app, user, auth
from api.v1.exceptions.BadStructure import BadStructure


# Base sign in method
def sign_in(login, password):
    usr = db.fetch_one("""
        SELECT * FROM users_read_auth_info({user_login}) LIMIT 1
    """.format(user_login=login))

    if usr and usr['password'] == md5(password).hexdigest():
        response = app.make_response(True)
        response.set_cookie(config['auth']['id_cookie'], login)
        response.set_cookie(config['auth']['pass_cookie'], usr['password'])
        return response

    return False


# User authentication api
@app.route('/sign/in', methods=['POST'])
def sign_in_from_json():
    if not request.json or not check_set(['password'], request.json):
        raise BadStructure
    return sign_in(**request.json)


@app.route('/sign/up', methods=['POST'])
def sign_up():
    if not request.json:
        raise BadStructure

    usr = user.create(request.json)
    if len(usr):
        return sign_in(usr['login'], request.json['password'])

    return False


@app.route('/sign/out', methods=['POST'])
@auth.login_required
def sign_out():
    response = app.make_response(True)
    response.set_cookie(config['auth']['id_cookie'], '')
    response.set_cookie(config['auth']['pass_cookie'], '')

    return response
