#!/bin/bash
echo "Сollect static"
python manage.py collectstatic --noinput

echo "Apply database migrations"
python manage.py migrate

echo "Starting server"
exec gunicorn api_yamdb.wsgi:application --bind 0:8000
