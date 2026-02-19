#!/bin/bash
set -e

echo "Starting Django Polls"

# Migraciones
python3 manage.py migrate --noinput

# Crear superusuario (no falla si ya existe)
python3 manage.py createsuperuser --noinput || true

# Static
python3 manage.py collectstatic --noinput

# Servidor de desarrollo
exec python3 manage.py runserver 0.0.0.0:7000
