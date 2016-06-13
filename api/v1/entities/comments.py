from helpers import db
from api.v1 import app
from api.v1.entities.comment import prepare_comment


def prepare_comments(comments):
    for i, comment in enumerate(comments):
        comments[i] = prepare_comment(comment)
    return comments


@app.route('/comments/<int:aid>', methods=['GET'])
def read_comments(aid):
    return prepare_comments(db.fetch("""
        SELECT * FROM comments_read({aid});
    """.format(aid=aid)))
