from flask import request
from api.v1 import app, db, make_path, check_set, gen_resp, list_to_sql
from api.v1.exceptions.BadStructure import BadStructure


@app.route(make_path('/tags/<status>'), methods=['GET'])
def read(status='any'):
    return gen_resp(
        db.fetch("""
            SELECT * FROM tags_read({status});
        """.format(status=status))
    )


@app.route(make_path('/tags'), methods=['POST'])
def create():
    if not check_set(['tags'], request.form):
        raise BadStructure

    with request.form as form:
        return db.fetch_one("""
            PERFORM tags_create({tags});
        """.format(tags=list_to_sql(form.tags)))[0]


@app.route(make_path('/tags'), methods=['PUT'])
def update():
    if not check_set(['tags', 'status'], request.form):
        raise BadStructure

    if request.form.status not in ['new', 'approved', 'declined']:
        raise BadStructure

    with request.form as form:
        return db.fetch_one("""
            PERFORM tags_update({tags}, {status});
        """.format(tags=list_to_sql(form.tags), status=form.status))[0]
