from flask import request
from api.v1 import app, db, make_path, gen_resp
from api.v1.exceptions.BadStructure import BadStructure


def prepare_query(query):
    to_replace = ['.', ',']

    for sym in to_replace:
        query.replace(sym, ' ')
    query.replace('  ', ' ')

    return query


@app.route(make_path('/users'), methods=['GET'])
def search():
    if not request.json:
        raise BadStructure

    results = db.fetch("""
        SELECT * FROM users_search({query});
    """.format(query=prepare_query(request.json.query)))

    return results
