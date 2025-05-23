# Use Alpine Linux as the base image
FROM alpine:3.16

# Install NGINX and necessary SSL packages
RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=XX/ST=State/L=City/O=Organization/CN=localhost"

# Create directory for NGINX pid file
RUN mkdir -p /run/nginx

# Copy the NGINX configuration
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

# Expose port 443 for HTTPS
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]