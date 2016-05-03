from flask import request
from helpers import db, check_set
from api.v1 import app, auth
from api.v1.exceptions.BadStructure import BadStructure


@app.route('/tags/<status>', methods=['GET'])
def read_by_status(status='any'):
    return db.fetch("""
            SELECT * FROM tags_read({status});
        """.format(status=status))


@app.route('/tags', methods=['POST'])
@auth.login_required
def create_tags():
    if not request.json or not check_set(['tags'], request.json):
        raise BadStructure

    return db.fetch_one("""
        PERFORM tags_create({tags});
    """.format(tags=app.list_to_sql(request.json.tags)))[0]


@app.route('/tags', methods=['PUT'])
@auth.login_required
def update_tags():
    if not request.json or not check_set(['tags', 'status'], request.json)\
            or request.json.status not in ['new', 'approved', 'declined']:
        raise BadStructure

    return db.fetch_one("""
        PERFORM tags_update({tags}, {status});
    """.format(tags=app.list_to_sql(request.json.tags), status=request.json.status))[0]
