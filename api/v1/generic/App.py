from flask import Flask, jsonify
from helpers import config


class App(Flask):
    user = None

    def __init__(self, name):
        super(App, self).__init__(name)
        self.config['SERVER_NAME'] = config['server']['host']
        self.register_handlers()

    def register_handlers(self):
        self._register_error_handler(None, Exception, self.on_exception)

    # Decorators
    def route(self, route, **options):
        def decorator(f):
            super(App, self).route(self.make_path(route), **options)(f)
        return decorator

    # Utils
    @staticmethod
    def on_exception(e):
        return App.gen_resp(e.to_dict(), e.status_code)

    @staticmethod
    def make_path(path):
        return '/api/v1' + path

    @staticmethod
    def list_to_sql(c_list):
        result = ''
        for v in c_list:
            result += '"' + v + '"'
        return '{' + result + '}'

    @staticmethod
    def gen_resp(params, status_code=200):
        response = jsonify(params)
        response.status_code = status_code
        return response
