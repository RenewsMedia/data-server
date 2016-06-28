import json
from functools import wraps
from flask import Flask, Response, make_response
from helpers import config
from api.v1.generic.crossdomain import crossdomain
from api.v1.generic.ProtoException import ProtoException


class App(Flask):
    user = None

    def __init__(self, name):
        super(App, self).__init__(name)

        self.config.update(
            SERVER_NAME=config['server']['host'],
            PROPAGATE_EXCEPTIONS=True,
            JSON_SORT_KEYS=False
        )

        self.register_handlers()

    def register_handlers(self):
        self._register_error_handler(None, ProtoException, self.on_exception)

    # Decorators
    def route(self, route, **options):
        def decorator(f):
            @crossdomain(origin='*')
            @wraps(f)
            def wrapped(*args, **kwargs):
                result = f(*args, **kwargs)
                return self.gen_resp(result)

            super(App, self).route(self.make_path(route), **options)(wrapped)
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
        result = []
        for v in c_list:
            result.append('"' + v + '"')
        return '\'{' + ','.join(result) + '}\''

    @staticmethod
    def gen_resp(params, status_code=200):
        if isinstance(params, Response):
            return params

        if not isinstance(params, dict) and not isinstance(params, list):
            params = {'result': params}

        response = make_response(json.dumps(params))
        response.status_code = status_code
        return response
