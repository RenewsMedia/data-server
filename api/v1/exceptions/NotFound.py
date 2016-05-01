from api.v1.exceptions.ProtoException import ProtoException


class NotFound(ProtoException):
    status_code = 404
    message = 'Not found'
