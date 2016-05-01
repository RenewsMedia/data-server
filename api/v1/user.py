from flask import request
from api.v1 import app, db, make_path, check_set
from api.v1.exceptions.BadStructure import BadStructure
from api.v1.exceptions.NotFound import NotFound


@app.route(make_path('/user/<int:user_id>'), methods=['GET'])
def read(user_id):
    result = db.fetch('PERFORM users_read_by_id({id})'.format(id=user_id))
    if not len(result):
        raise NotFound
    return result[0]


@app.route(make_path('/user'), methods=['POST'])
def create():
    if not check_set(['login', 'password', 'mail', 'country', 'name', 'surname'], request.form):
        raise BadStructure

    with request.form as form:
        return db.fetch("""
            PERFORM users_create({login}, {password}, {mail}, {country}, {name}, {surname})
        """.format(**form))[0]


@app.route(make_path('/user/<int:user_id>'), methods=['PUT'])
def update(user_id):
    if not check_set(['mail', 'country', 'name', 'surname'], request.form):
        raise BadStructure

    with request.form as form:
        return db.fetch("""
            PERFORM users_update({id}, {mail}, {country}, {name}, {surname})
        """.format(id=user_id, **form))[0]


# /user/password
@app.route(make_path('/user/password/<int:user_id>'), methods=['PUT'])
def update_password(user_id):
    if not check_set(['password'], request.form):
        raise BadStructure

    with request.form as form:
        return db.fetch("""
            PERFORM users_update_password({id}, {password})
        """.format(id=user_id, **form))[0]
