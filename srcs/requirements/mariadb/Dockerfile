# Use Alpine Linux as the base image
FROM alpine:3.16

# Install MariaDB and dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache mariadb mariadb-client

# Create necessary directories
RUN mkdir -p /run/mysqld /var/lib/mysql

# Set permissions for MariaDB directories
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copy the initialization script
COPY ./tools/init_db.sh /usr/local/bin/
COPY ./conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

# Make the initialization script executable
RUN chmod +x /usr/local/bin/init_db.sh

# Expose the MariaDB port
EXPOSE 3306

# Start MariaDB with the initialization script
ENTRYPOINT ["init_db.sh"]