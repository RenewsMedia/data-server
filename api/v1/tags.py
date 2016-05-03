from flask import request
from api.v1 import app, auth, db, make_path, check_set, list_to_sql
from api.v1.exceptions.BadStructure import BadStructure


@app.route(make_path('/tags/<status>'), methods=['GET'])
def read_by_status(status='any'):
    return db.fetch("""
            SELECT * FROM tags_read({status});
        """.format(status=status))


@app.route(make_path('/tags'), methods=['POST'])
@auth.login_required
def create():
    if not request.json or not check_set(['tags'], request.json):
        raise BadStructure

    with request.json as data:
        return db.fetch_one("""
            PERFORM tags_create({tags});
        """.format(tags=list_to_sql(data.tags)))[0]


@app.route(make_path('/tags'), methods=['PUT'])
@auth.login_required
def update():
    if not request.json or not check_set(['tags', 'status'], request.json):
        raise BadStructure

    if request.json.status not in ['new', 'approved', 'declined']:
        raise BadStructure

    with request.json as data:
        return db.fetch_one("""
            PERFORM tags_update({tags}, {status});
        """.format(tags=list_to_sql(data.tags), status=data.status))[0]
