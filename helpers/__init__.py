import json
from helpers.DbConnection import DbConnection

with open('config.json') as config:
    config = json.load(config)


db = DbConnection(config['db'])


def check_set(schema, c_dict):
    if not isinstance(c_dict, dict):
        return False

    return all(k in c_dict for k in schema)
