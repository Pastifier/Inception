# Use Alpine Linux as the base image
FROM alpine:3.16

# Install PHP-FPM and necessary extensions for WordPress
RUN apk update && apk upgrade && \
    apk add --no-cache \
    php8 \
    php8-fpm \
    php8-mysqli \
    php8-json \
    php8-curl \
    php8-dom \
    php8-exif \
    php8-fileinfo \
    php8-mbstring \
    php8-openssl \
    php8-xml \
    php8-zip \
    php8-phar \
    curl \
    wget \
    mysql-client

# Create the directory for WordPress
RUN mkdir -p /var/www/html

# Configure PHP-FPM
RUN mkdir -p /etc/php8/php-fpm.d
COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

# Download WP-CLI for WordPress installation
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy the WordPress setup script
COPY ./tools/wp-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-setup.sh

# Set working directory
WORKDIR /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM with the WordPress setup script
ENTRYPOINT ["wp-setup.sh"]
