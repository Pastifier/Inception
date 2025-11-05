FROM alpine:3.21

RUN apk update && \
    apk add --no-cache nginx openssl

RUN mkdir -p /var/www/html/wordpress

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY --chmod=755 ./docker-entrypoint.sh /docker-entrypoint.sh

RUN mkdir -p /etc/ssl/private /etc/ssl/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=AE/ST=AbuDhabi/L=AbuDhabi/O=42/CN=ebinjama.42.fr" && \
    chmod 600 /etc/ssl/private/nginx-selfsigned.key && \
    chmod 644 /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 443

ENTRYPOINT ["/docker-entrypoint.sh"]