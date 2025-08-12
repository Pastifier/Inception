#!/bin/sh
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    # Start temporary MariaDB server for setup
    mariadbd --user=mysql --skip-networking &
    pid="$!"

    until mariadb-admin ping --silent; do
        sleep 1
    done

    echo "Setting up database and users..."
    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
    mariadb -e "CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASS}';"
    mariadb -e "GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO '${DATABASE_USER}'@'%';"
    mariadb -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mariadb -e "FLUSH PRIVILEGES;"

    # Shutdown temporary MariaDB
    mariadb-admin shutdown
    wait "$pid"
fi

echo "Starting MariaDB..."
exec "$@"
