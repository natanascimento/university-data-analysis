from fastapi import Depends
from infrastructure.repositories.sink import DatabaseSink
from routes.sink.contracts import CreateSinkConnectionRequest


class CreateSink:

    def __init__(self, repository: DatabaseSink = Depends()):
        self.__repository = repository

    def execute(self, request: CreateSinkConnectionRequest):
        return self.__repository.create(request)
