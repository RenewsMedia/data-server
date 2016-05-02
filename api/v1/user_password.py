from flask import request
from api.v1 import app, db, make_path, check_set, gen_resp
from api.v1.exceptions.BadStructure import BadStructure


@app.route(make_path('/user/password/<int:user_id>'), methods=['PUT'])
def update_password(user_id):
    if not check_set(['password'], request.form):
        raise BadStructure

    result = db.fetch_one("""
        PERFORM users_update_password({id}, {password})
    """.format(id=user_id, password=request.form.password))[0]

    return gen_resp({'result': result})
