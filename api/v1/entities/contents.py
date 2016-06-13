from helpers import db
from api.v1.exceptions.BadStructure import BadStructure


def create_contents(article_id, contents):
    for contents_entry in contents:
        if not contents_entry['url'] and not contents_entry['data']:
            raise BadStructure
        db.execute("""
            SELECT * FROM contents_create('{type}', {aid}, '{url}', '{data}', '{order}')
        """.format(aid=article_id, **contents_entry))
