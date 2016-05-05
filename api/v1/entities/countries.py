from helpers import db
from api.v1 import app

countries = db.fetch("""
        SELECT * FROM "countries" ORDER BY "code";
    """)


@app.route('/countries', methods=['GET'])
def get_countries():
    return countries
