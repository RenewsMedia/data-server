from flask import request
from helpers import db, check_set
from api.v1 import app, auth
from api.v1.entities import contents
from api.v1.exceptions.BadStructure import BadStructure
from api.v1.exceptions.ServerError import ServerError


def prepare_article(article):
    article['created'] = article['created'].timestamp()
    article['published'] = article['published'].timestamp()
    return article


def get_full_article(aid):
    article = prepare_article(db.fetch_one("""
        SELECT * FROM "articles" WHERE "id" = {aid};
    """.format(aid=aid)))

    if not article:
        return False

    article['contents'] = db.fetch("""
        SELECT * FROM "contents" WHERE "article" = {aid} ORDER BY "order";
    """.format(aid=aid))
    return article


@app.route('/article/<int:aid>', methods=['GET'])
def read_article(aid):
    return get_full_article(aid)


@app.route('/article', methods=['POST'])
@auth.login_required
def create_article():
    if not request.json or not check_set(['channel', 'title', 'contents', 'tags'], request.json):
        raise BadStructure

    if isinstance(request.json['tags'], list):
        request.json['tags'] = app.list_to_sql(request.json['tags'])

    cursor = db.cursor()
    cursor.execute("""
        SELECT * FROM articles_create({channel}, {author}, '{title}', {tags}, {contents});
    """.format(author=app.user['id'], **request.json))
    aid = cursor.fetchall()[0]['articles_create']

    if aid != -1:
        try:
            contents.create_contents(aid, request.json['contents'])
        except BadStructure:
            db.rollback()
            cursor.close()
            raise BadStructure

        db.commit()
        cursor.close()
        return get_full_article(aid)

    db.rollback()
    cursor.close()
    raise ServerError


@app.route('/article/<int:aid>', methods=['PUT'])
@auth.login_required
def update_article(aid):
    if not request.json or not check_set(['title', 'contents', 'tags'], request.json):
        raise BadStructure

    if isinstance(request.json['tags'], list):
        request.json['tags'] = app.list_to_sql(request.json['tags'])

    cursor = db.cursor()
    cursor.execute("""
        SELECT * FROM articles_update({aid}, {emitter}, '{title}', {tags});
    """.format(aid=aid, emitter=app.user['id'], **request.json))
    result = cursor.fetchall()[0]['articles_update']

    if result:
        try:
            contents.create_contents(aid, request.json['contents'])
        except BadStructure:
            db.rollback()
            cursor.close()
            raise BadStructure

        db.commit()
        cursor.close()
        return get_full_article(aid)

    db.rollback()
    cursor.close()
    raise ServerError


@app.route('/article/<int:aid>', methods=['DELETE'])
@auth.login_required
def delete_article(aid):
    return db.fetch_one("""
        SELECT * FROM articles_delete({aid}, {emitter});
    """.format(aid=aid, emitter=app.user['id']))['articles_delete']
