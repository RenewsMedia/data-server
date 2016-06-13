from flask import request
from helpers import db, check_set
from api.v1 import app, auth
from api.v1.exceptions.BadStructure import BadStructure


def prepare_comment(comment):
    comment['published'] = comment['published'].timestamp()
    return comment


@app.route('/comment/<int:cid>', methods=['GET'])
def read_comment(cid):
    return prepare_comment(db.fetch_one("""
        SELECT * FROM comments_read_single({cid})
    """.format(cid=cid)))


@app.route('/comment', methods=['POST'])
@auth.login_required
def create_comment():
    if not request.json or not check_set(['article', 'text'], request.json):
        raise BadStructure

    return prepare_comment(db.fetch_one("""
        SELECT * FROM comments_create({author}, {article}, '{text}', NULL);
    """.format(author=app.user['id'], **request.json)))


@app.route('/comment/<int:cid>', methods=['DELETE'])
@auth.login_required
def delete_comment(cid):
    return db.fetch_one("""
        SELECT * FROM comments_delete({cid}, {emitter})
    """.format(cid=cid, emitter=app.user['id']))['comments_delete']
