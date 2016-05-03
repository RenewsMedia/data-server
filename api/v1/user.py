from flask import request
from api.v1 import app, auth, db, check_set
from api.v1.exceptions.BadStructure import BadStructure
from api.v1.exceptions.NotFound import NotFound


@app.route('/user/<int:user_id>', methods=['GET'])
def read(user_id):
    user = db.fetch_one("""
        SELECT * FROM users_read_by_id({id}) LIMIT 1;
    """.format(id=user_id))

    if not user:
        raise NotFound

    return user


def create(data):
    if not check_set(['login', 'password', 'mail', 'country', 'name', 'surname'], data):
        raise BadStructure

    return db.fetch_one("""
            SELECT * FROM users_create({login}, {password}, {mail}, {country}, {name}, {surname}) LIMIT 1;
        """.format(**data))


@app.route('/user/<int:user_id>', methods=['PUT'])
@auth.login_required
def update(user_id):
    if not request.json or not check_set(['mail', 'country', 'name', 'surname'], request.json):
        raise BadStructure

    with request.json as data:
        return db.fetch_one("""
                SELECT * FROM users_update({id}, {mail}, {country}, {name}, {surname}) LIMIT 1;
            """.format(id=user_id, **data))


# /user/password
@app.route('/user/password/<int:user_id>', methods=['PUT'])
@auth.login_required
def update_password(user_id):
    if not request.json or not check_set(['password'], request.json):
        raise BadStructure

    result = db.fetch_one("""
        SELECT * FROM users_update_password({id}, {password}) LIMIT 1;
    """.format(id=user_id, password=request.json.password))[0]

    return result
