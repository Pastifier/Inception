#!/bin/sh

set -e

if [ ! -f "/var/lib/mysql/ib_buffer_pool" ]; then
    echo "Initializing MariaDB data directory..."
    /etc/init.d/mariadb setup

    echo "Starting MariaDB for initialization..."
    rc-service mariadb start

    # 👉 Wait until MariaDB is actually accepting connections
    echo "Waiting for MariaDB to be ready..."
    while ! mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "SELECT 1" >/dev/null 2>&1; do
        echo "Still waiting for MariaDB to accept connections..."
        sleep 2
    done

    # Now create user and database
    echo "Creating database and user for WordPress..."

    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"

    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"

    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "ALTER USER '$MYSQL_ROOT_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS';"

    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "FLUSH PRIVILEGES;"

    echo "Database setup complete."

    # Stop MariaDB cleanly before starting in foreground
    rc-service mariadb stop
fi

# Enable networking
sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
sed -i 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/g' /etc/my.cnf.d/mariadb-server.cnf

# Start MariaDB in foreground
exec /usr/bin/mariadbd --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mariadb/plugin --user=mysql --pid-file=/run/mysqld/mariadb.pid