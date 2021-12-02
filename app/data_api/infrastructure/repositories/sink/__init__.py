import os
from datetime import datetime
import pandas as pd
import sqlalchemy
from domain.sink.entities import SinkCreationResponse


class DatabaseSink:

    def __init__(self):
        self.__AWS_ACCESS_KEY_ID = os.getenv('AWS_ACCESS_KEY_ID')
        self.__AWS_SECRET_ACCESS_KEY = os.getenv('AWS_SECRET_ACCESS_KEY')
        self.__USER = 'university'
        self.__PASS = 'university'
        self.__HOST = '18.206.135.57'
        self.__DATABASE = 'university'
        self.__BRONZE_LAYER = 'university-datalake-bronze'
        self.__DATETIME = datetime.today()

    @staticmethod
    def generate_postgresql_uri(user: str, passw: str, host:str, database:str):
        return 'postgresql://{}:{}@{}:5432/{}'.format(user, passw, host, database)
    
    def generate_file_path(self, table: str, file_format: str):
        return f"YYYY={self.__DATETIME.year}/mm={self.__DATETIME.month}/dd={self.__DATETIME.day}/table={table.table_name}/{table.table_name}.{file_format}"

    def create(self, table: str):

        engine = sqlalchemy.create_engine(self.generate_postgresql_uri(user=self.__USER, passw=self.__PASS,
                                                                host=self.__HOST, database=self.__DATABASE))

        query = f"SELECT * FROM university.{table.table_name}"

        df = pd.read_sql_query(query, engine)

        df = df.astype(str)

        df.to_parquet(
            "s3://{}/{}".format(self.__BRONZE_LAYER,
                                self.generate_file_path(table=table,
                                                        file_format="parquet")),
            storage_options={
                "key": self.__AWS_ACCESS_KEY_ID,
                "secret": self.__AWS_SECRET_ACCESS_KEY
            },                                                                 
            index=False,
            engine="fastparquet"
        )

        return SinkCreationResponse(table_name=table)