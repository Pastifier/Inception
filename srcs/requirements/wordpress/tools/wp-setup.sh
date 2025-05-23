#!/bin/sh

# Wait for MariaDB to be ready
while ! mysqladmin ping -h${WORDPRESS_DB_HOST} -u${WORDPRESS_DB_USER} -p${WORDPRESS_DB_PASSWORD} --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Check if WordPress is already installed
if [ ! -f "/var/www/html/wp-config.php" ]; then
    # Download WordPress
    wp core download --allow-root

    # Create the wp-config.php file
    wp config create --dbname=${WORDPRESS_DB_NAME} \
                   --dbuser=${WORDPRESS_DB_USER} \
                   --dbpass=${WORDPRESS_DB_PASSWORD} \
                   --dbhost=${WORDPRESS_DB_HOST} \
                   --allow-root

    # Install WordPress
    wp core install --url=${DOMAIN_NAME} \
                    --title=${WORDPRESS_TITLE} \
                    --admin_user=${WORDPRESS_ADMIN_USER} \
                    --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
                    --admin_email=${WORDPRESS_ADMIN_EMAIL} \
                    --allow-root

    # Set the correct permissions
    chown -R nobody:nobody /var/www/html
    
    echo "WordPress has been installed and configured!"
else
    echo "WordPress is already installed!"
fi

# Start PHP-FPM
exec php-fpm8 -F
