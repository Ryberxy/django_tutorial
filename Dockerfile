FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    pkg-config \
    default-libmysqlclient-dev \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN chmod +x entrypoint.sh \
    && pip install -r requirements.txt

EXPOSE 7000

CMD ["./entrypoint.sh"]

