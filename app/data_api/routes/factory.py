from fastapi import APIRouter, status


class RouterFactory:

    def __init__(self, version: str, tag: str):
        self.__router = APIRouter(
            prefix=f"/api/{version}",
            tags=[f"{tag}-{version}"],
            responses={status.HTTP_404_NOT_FOUND: {"description": "Not found"}},
        )

    @property
    def get(self) -> APIRouter:
        return self.__router
