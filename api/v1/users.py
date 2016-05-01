from flask import request
from api.v1 import app, db, make_path, gen_resp
from api.v1.exceptions.NotFound import NotFound


@app.route(make_path('/users'), methods=['GET'])
def search():
    results = db.fetch("""
        PERFORM users_search({query})
    """.format(query=request.form.query))

    if not len(results):
        raise NotFound

    return gen_resp(results)
