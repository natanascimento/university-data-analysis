from fastapi import FastAPI

from routes import sink

app = FastAPI()

app.include_router(sink.router)