FROM python:3-alpine

LABEL maintainer=joe@twr.io

COPY ./Pipfile* /app/

WORKDIR /app

RUN apk add --update --no-cache ca-certificates

RUN pip install pipenv

RUN pipenv install --system --deploy

COPY ./hello.py /app/

COPY ./config.py /app/

CMD ["gunicorn", "hello:app", "--config=config.py"]
