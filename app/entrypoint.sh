#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi


# we're still running the database flush (which clears out the database) and migrate commands every time the container is run? This is fine in development
python manage.py flush --no-input
python manage.py migrate

exec "$@"
