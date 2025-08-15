#!/bin/sh

if [ ! -f /var/www/html/wordpress/wp-config-sample.php ]; then
    echo "WordPress not found, downloading..."
    mkdir -p /var/www/html/wordpress
    cd /tmp
    wget -q https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -a /tmp/wordpress/. /var/www/html/wordpress/
    rm -rf /tmp/wordpress latest.tar.gz
    cd /var/www/html/wordpress
fi

# Set the Database Credentials
sed -i 's|DB_NAME_here|'${DB_NAME}'|g' /var/www/html/wordpress/wp-config-sample.php
sed -i 's|username_here|'${DB_USER}'|g' /var/www/html/wordpress/wp-config-sample.php
sed -i 's|password_here|'${DB_PASSWORD}'|g' /var/www/html/wordpress/wp-config-sample.php
sed -i 's|localhost|'${DB_HOST}'|g' /var/www/html/wordpress/wp-config-sample.php

chmod -R 755 /var/www/html/wordpress
chown -R nobody:nobody /var/www/html/wordpress
cd /var/www/html/wordpress/
# sleep 5

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to accept connections..."
until mariadb -h "$DB_HOST" -u "$DB_USER" --password="$DB_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
  echo "Still waiting for MariaDB..."
  sleep 4
done
echo "✅ Connected to MariaDB"

if [ -f /var/www/html/wordpress/wp-config.php ]; then
    echo "WordPress already configured."
else
    cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
    wp --allow-root core install --url="$DOMAIN_NAME" --title="$CORE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_USER_PASS" --admin_email="$ADMIN_USER_EMAIL" --skip-email --path=/var/www/html/wordpress
fi

wp user create "$ADMIN_USER" "$ADMIN_USER_EMAIL" --role=administrator --user_pass="$ADMIN_USER_PASS" --skip-email

wp --allow-root user create "$NORMAL_USER" "$NORMAL_USER_EMAIL" --role=subscriber --user_pass="$NORMAL_USER_PASS" --path=/var/www/html/wordpress

sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g' /etc/php83/php-fpm.d/www.conf

exec /usr/sbin/php-fpm83 -FR