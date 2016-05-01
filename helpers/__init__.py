import json
from helpers.DbConnection import DbConnection

with open('config.json') as config:
    config = json.load(config)


db = DbConnection(config['db'])
