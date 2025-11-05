#!/bin/sh

set -e

echo "DB_NAME=$DB_NAME"
echo "DB_USER=$DB_USER"
echo "MYSQL_ROOT_USER=$MYSQL_ROOT_USER"

if [ ! -f "/var/lib/mysql/ib_buffer_pool" ]; then
    echo "First boot detected. Initializing database..."
    /etc/init.d/mariadb setup
    rc-service mariadb start

    echo "Waiting for MariaDB to accept connections..."
    counter=0
    while ! mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "SELECT 1" >/dev/null 2>&1; do
        counter=$((counter + 1))
        if [ $counter -gt 30 ]; then
            echo "❌ MariaDB failed to start after 60 seconds"
            exit 1
        fi
        echo "Still waiting... ($counter)"
        sleep 2
    done
    echo "✅ MariaDB is ready"

    echo "Creating database '$DB_NAME'..."
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

    echo "Creating user '$DB_USER'@'localhost'..."
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"

    echo "Creating user '$DB_USER'@'%'..."
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"

    echo "Flushing privileges..."
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "FLUSH PRIVILEGES;"

    echo "Changing root password..."
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASS" -e "ALTER USER '$MYSQL_ROOT_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS';"

    echo "Database setup complete."

    rc-service mariadb stop
else
    echo "⚠️  MariaDB data directory already exists. Skipping setup."
fi

# Enable networking
sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
sed -i 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/g' /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mariadbd --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mariadb/plugin --user=mysql --pid-file=/run/mysqld/mariadb.pid