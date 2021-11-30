FROM python:3.8

COPY ./app/data_api /src

COPY ./requirements.txt /src/requirements.txt

WORKDIR src

EXPOSE 8080:8080

RUN pip install -r requirements.txt

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080", "--reload" ]
