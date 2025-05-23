#!/bin/sh

# Check if the database directory is empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialize the MariaDB database
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB server
    mysqld --user=mysql --bootstrap << EOF
# Set root password
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;

# Create database and user for WordPress
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
fi

# Start MariaDB server
exec mysqld --user=mysql
