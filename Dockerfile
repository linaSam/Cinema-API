FROM python:3.9.6-alpine

LABEL mainteiner="salina.amoylenko@gmail.com"

ENV PYTHONUNBUFFERED 1

WORKDIR app/

RUN apk add -u zlib-dev jpeg-dev gcc musl-dev
RUN python3 -m pip install --upgrade pip

COPY requirements.txt requirements.txt


RUN pip install -r requirements.txt

COPY . .

RUN mkdir -p /vol/app/media

RUN adduser \
    --disabled-password \
    --no-create-home \
    django-user

RUN chown -R django-user:django-user /vol/
RUN chmod -R 755 /vol/app/

USER django-user
