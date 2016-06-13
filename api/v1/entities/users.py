from flask import request
from helpers import db
from api.v1 import app
from api.v1.entities import user
from api.v1.exceptions.BadStructure import BadStructure


def prepare_users(users):
    return [user.prepare_user(usr) for usr in users]


def prepare_query(query):
    for sym in ['.', ',']:
        query.replace(sym, ' ')
    return query.replace('  ', ' ')


@app.route('/users', methods=['GET'])
def search():
    if not request.args:
        raise BadStructure

    return prepare_users(db.fetch("""
        SELECT * FROM users_search('{query}');
    """.format(query=prepare_query(request.args.get('query')))))
