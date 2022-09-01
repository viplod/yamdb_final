FROM python:3.7-slim

WORKDIR /app

COPY requirements.txt .

RUN pip3 install -r ./requirements.txt --no-cache-dir

COPY . .

RUN python manage.py collectstatic --noinput

COPY docker-entrypoint.sh /app

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
