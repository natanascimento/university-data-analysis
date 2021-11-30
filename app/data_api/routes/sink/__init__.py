from routes.factory import RouterFactory
from routes.sink.contracts import CreateSinkConnectionRequest
from domain.sink.use_cases import CreateSink
from fastapi import Depends

router = RouterFactory(version="v1", tag="sink").get


@router.post("/data/sink",
             response_description="Create a sink database connection",
             status_code=201)
def create_topic(sink_create_request: CreateSinkConnectionRequest, sink_create: CreateSink = Depends()):
    return sink_create.execute(sink_create_request).message
