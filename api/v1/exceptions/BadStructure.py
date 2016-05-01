from api.v1.exceptions.ProtoException import ProtoException


class BadStructure(ProtoException):
    status_code = 400
    message = 'Bad structure'
