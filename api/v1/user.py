from flask import request
from api.v1 import app, db, make_path, check_set, gen_resp
from api.v1.exceptions.BadStructure import BadStructure
from api.v1.exceptions.NotFound import NotFound


@app.route(make_path('/user/<int:user_id>'), methods=['GET'])
def read(user_id):
    user = db.fetch_one("""
        PERFORM users_read_by_id({id})
    """.format(id=user_id))

    if not user:
        raise NotFound

    return gen_resp(user)


@app.route(make_path('/user'), methods=['POST'])
def create():
    if not check_set(['login', 'password', 'mail', 'country', 'name', 'surname'], request.form):
        raise BadStructure

    with request.form as form:
        return gen_resp(
            db.fetch_one("""
                PERFORM users_create({login}, {password}, {mail}, {country}, {name}, {surname})
            """.format(**form))
        )


@app.route(make_path('/user/<int:user_id>'), methods=['PUT'])
def update(user_id):
    if not check_set(['mail', 'country', 'name', 'surname'], request.form):
        raise BadStructure

    with request.form as form:
        return gen_resp(
            db.fetch_one("""
                PERFORM users_update({id}, {mail}, {country}, {name}, {surname})
            """.format(id=user_id, **form))
        )
