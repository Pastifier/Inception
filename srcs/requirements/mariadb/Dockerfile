FROM alpine:3.21

RUN <<EOF
apk update
apk add mariadb mariadb-common mariadb-client openrc
openrc
touch /run/openrc/softlevel
EOF

COPY --chmod=755 ./docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 3306

# Ensure the mysqld socket directory exists
RUN mkdir -p /run/mysqld
RUN chown mysql:mysql /run/mysqld
RUN service mysql start

ENTRYPOINT [ "/docker-entrypoint.sh" ]