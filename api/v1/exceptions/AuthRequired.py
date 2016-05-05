from api.v1.generic.ProtoException import ProtoException


class AuthRequired(ProtoException):
    status_code = 403
    message = 'Auth required'
