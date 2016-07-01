from flask import request
from helpers import db, check_set
from api.v1 import app, auth
from api.v1.exceptions.BadStructure import BadStructure
from api.v1.exceptions.NotFound import NotFound


def prepare_user(user):
    del user['password']
    user['date_reg'] = user['date_reg'].timestamp()
    return user


@app.route('/user/<int:user_id>', methods=['GET'])
def read(user_id):
    user = db.fetch_one("""
        SELECT * FROM users_read_by_id({id});
    """.format(id=user_id))

    if not user:
        raise NotFound
    return prepare_user(user)


def create(data):
    if not check_set(['login', 'password', 'mail', 'country', 'name', 'surname'], data):
        raise BadStructure
    return db.fetch_one("""
            SELECT * FROM users_create('{login}', '{password}', '{mail}', '{country}', '{name}', '{surname}');
        """.format(**data))


@app.route('/user/<int:user_id>', methods=['PUT'])
@auth.login_required
def update(user_id):
    if not check_set(['mail', 'country', 'name', 'surname'], request.form):
        raise BadStructure

    return prepare_user(db.fetch_one("""
            SELECT * FROM users_update({id}, '{mail}', '{country}', '{name}', '{surname}');
        """.format(id=user_id, **request.form)))


# /user/password
@app.route('/user/password/<int:user_id>', methods=['PUT'])
@auth.login_required
def update_password(user_id):
    if not check_set(['password'], request.form):
        raise BadStructure

    return db.fetch_one("""
        SELECT * FROM users_update_password({id}, '{password}');
    """.format(id=user_id, password=request.form['password']))['users_update_password']
