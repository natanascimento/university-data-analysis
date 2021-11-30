from pydantic import BaseModel, Field


class CreateSinkConnectionRequest(BaseModel):
    table_name: str = Field(min_length=1, max_length=249)

    class Config:
        allow_mutation = False
        schema_extra = {
            "example": {
                "table_name": "table-X",
            }
        }
