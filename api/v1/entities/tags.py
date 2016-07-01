from flask import request
from helpers import db, check_set
from api.v1 import app, auth
from api.v1.exceptions.BadStructure import BadStructure


def read_by_status(status='any'):
    return db.fetch("""
        SELECT * FROM tags_read('{status}');
    """.format(status=status))


@app.route('/tags', methods=['GET'])
def read_by_default_status():
    return read_by_status()


@app.route('/tags/<status>', methods=['GET'])
def read_by_defined_status(status):
    return read_by_status(status)


@app.route('/tags', methods=['POST'])
@auth.login_required
def create_tags():
    if not check_set(['tags'], request.form):
        raise BadStructure

    db.fetch_one("""
        SELECT * FROM tags_create({tags});
    """.format(tags=app.list_to_sql(request.form['tags'])))

    return True


@app.route('/tags', methods=['PUT'])
@auth.login_required
def update_tags():
    if not check_set(['tags', 'status'], request.form):
        raise BadStructure

    if request.form['status'] not in ['new', 'approved', 'declined']:
        raise BadStructure

    return db.fetch_one("""
        SELECT * FROM tags_update({tags}, '{status}');
    """.format(tags=app.list_to_sql(request.form['tags']), status=request.form['status']))['tags_update']
