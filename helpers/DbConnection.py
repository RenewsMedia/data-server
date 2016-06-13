import psycopg2
import psycopg2.extras


class DbConnection:
    db = None

    def __init__(self, config):
        self.connect(config)

    def connect(self, config):
        self.db = psycopg2.connect(
                host=config['host'],
                port=config['port'],
                user=config['user'],
                password=config['password'],
                dbname=config['name']
            )

    def cursor(self):
        return self.db.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

    def commit(self):
        self.db.commit()

    def rollback(self):
        self.db.rollback()

    def close(self):
        self.db.close()

    def execute(self, query):
        cursor = self.cursor()
        cursor.execute(query)
        self.commit()
        cursor.close()

    def fetch(self, query):
        cursor = self.cursor()
        cursor.execute(query)
        self.commit()
        result = cursor.fetchall()
        cursor.close()
        return result

    def fetch_one(self, query):
        cursor = self.cursor()
        cursor.execute(query)
        self.commit()
        result = cursor.fetchone()
        cursor.close()
        return result
