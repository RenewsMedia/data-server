from flask import request
from api.v1 import app, make_path, db


@app.route(make_path('/user<int:user_id>'), methods=['GET'])
def get(user_id):
    return user_id


@app.route(make_path('/user<int:user_id>'), methods=['POST'])
def post():
    with request.form as form:
        db.execute("""
            PERFORM users_create({login}, {password}, {mail}, {country}, {name}, {surname})
        """.format(**form))
