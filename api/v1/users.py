from flask import request
from api.v1 import app, db, make_path, gen_resp
from api.v1.exceptions.NotFound import NotFound


def prepare_query(query):
    to_replace = ['.', ',']

    for i in to_replace:
        query.replace(to_replace[i], ' ')
    query.replace('  ', ' ')

    return query


@app.route(make_path('/users'), methods=['GET'])
def search():
    results = db.fetch("""
        PERFORM users_search({query})
    """.format(query=prepare_query(request.form.query)))

    if not len(results):
        raise NotFound

    return gen_resp(results)
