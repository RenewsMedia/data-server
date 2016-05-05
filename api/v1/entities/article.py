from flask import request
from helpers import db, check_set
from api.v1 import app, auth
from api.v1.entities import contents
from api.v1.exceptions.BadStructure import BadStructure
from api.v1.exceptions.ServerError import ServerError


def get_full_article(aid):
    article = db.fetch_one("""
        SELECT * FROM "articles" WHERE "id" = {aid};
    """.format(aid=aid))

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
    with request.json as data:
        if not data or not check_set(['channel', 'title', 'contents', 'tags'], data):
            raise BadStructure
        cursor = db.cursor()
        aid = cursor.fetchall("""
            SELECT * FROM articles_create({channel}, {author}, '{title}', {tags});
        """.format(author=app.user['id'], tags=app.list_to_sql(data['tags']), **data))['articles_create']

        if aid != -1:
            try:
                contents.create_contents(aid, contents)
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
