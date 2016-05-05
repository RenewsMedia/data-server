from api.v1.generic.ProtoException import ProtoException


class ServerError(ProtoException):
    status_code = 500
    message = 'Internal server error'
