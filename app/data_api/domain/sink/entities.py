from dataclasses import dataclass, field

@dataclass
class SinkCreationResponse:
    table_name: str
    message: str = field(init=False)

    def __post_init__(self):
        self.message = f"Table {self.table_name.table_name} was created"


@dataclass
class Sink:
    table_name: str

