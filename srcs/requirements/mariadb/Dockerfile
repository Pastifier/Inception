FROM alpine:3.21

RUN <<EOF
apk update
apk add mariadb mariadb-common mariadb-client openrc
openrc
touch /run/openrc/softlevel
EOF

RUN <<EOF
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chmod 755 /run/mysqld
EOF

COPY --chmod=755 ./docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "/docker-entrypoint.sh" ]
