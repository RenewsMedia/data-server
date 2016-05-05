from api.v1.generic.ProtoException import ProtoException


class BadStructure(ProtoException):
    status_code = 400
    message = 'Bad structure'
