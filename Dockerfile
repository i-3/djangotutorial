FROM python:3.11.4-slim-bullseye AS BASE

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR /app

COPY ./requirements.txt ./

RUN apt-get update && \
    apt-get install -y \
      gcc \
      default-libmysqlclient-dev \
      pkg-config \
      curl && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get remove -y \
      gcc \
      pkg-config && \
    rm -rf /var/lib/apt/lists/*

COPY . .

EXPOSE 8000