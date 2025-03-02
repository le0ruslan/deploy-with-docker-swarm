FROM postgres:15-alpine

LABEL version="1.0" maintainer="le0ruslan@mail.ru"

WORKDIR /database

COPY *.sql /docker-entrypoint-initdb.d/
