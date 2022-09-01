#!/bin/bash

echo "Apply database migrations"
python manage.py migrate

echo "Starting server"
exec gunicorn api_yamdb.wsgi:application --bind 0:8000
