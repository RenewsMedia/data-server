from flask import request
from helpers import db, check_set
from api.v1 import app, auth
from api.v1.exceptions.BadStructure import BadStructure


def prepare_channel(channel):
    if channel is not None:
        channel['date_create'] = channel['date_create'].timestamp()
    return channel


@app.route('/channel/<int:cid>', methods=['GET'])
def get_channel_info(cid):
    return prepare_channel(db.fetch_one("""
        SELECT * FROM channels_read_by_id({cid});
    """.format(cid=cid)))


@app.route('/channel', methods=['POST'])
@auth.login_required
def create_channel():
    if not check_set(['name', 'description'], request.form):
        raise BadStructure

    return prepare_channel(db.fetch_one("""
        SELECT * FROM channels_create({owner}, '{name}', '{description}');
    """.format(owner=app.user['id'], **request.form)))


@app.route('/channel/<int:cid>', methods=['PUT'])
@auth.login_required
def update_channel(cid):
    if not check_set(['name', 'description'], request.form):
        raise BadStructure

    return prepare_channel(db.fetch_one("""
        SELECT * FROM channels_update({cid}, '{name}', '{description}', {emitter});
    """.format(emitter=app.user['id'], cid=cid, **request.form)))


@app.route('/channel/<int:cid>', methods=['DELETE'])
@auth.login_required
def delete_channel(cid):
    return db.fetch_one("""
        SELECT * FROM channels_delete({cid}, {emitter});
    """.format(cid=cid, emitter=app.user['id']))['channels_delete']
