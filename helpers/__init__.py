import json
from helpers.DbConnection import DbConnection

with open('config.json') as config:
    config = json.load(config)


db = DbConnection(config['db'])


def check_set(schema, c_dict):
    keys = c_dict.keys()
    for i in schema:
        if not i in keys:
            return False

    return True
