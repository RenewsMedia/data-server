from api.v1.generic.ProtoException import ProtoException


class NotFound(ProtoException):
    status_code = 404
    message = 'Not found'
