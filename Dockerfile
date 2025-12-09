ARG PHP_VERSION=8.2

FROM dunglas/frankenphp:1-php${PHP_VERSION}-alpine

LABEL org.opencontainers.image.source=https://github.com/whilesmartphp/frankenphp
LABEL org.opencontainers.image.description="Base image for PHP applications using FrankenPHP"
LABEL org.opencontainers.image.vendor="WhileSmart LLC"
LABEL org.opencontainers.image.licenses=MIT

RUN apk add --no-cache \
    curl \
    libzip-dev \
    libpng-dev \
    libxml2-dev \
    oniguruma-dev \
    freetype-dev \
    libjpeg-turbo-dev

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

WORKDIR /var/www/html

RUN mkdir -p /data/caddy /config/caddy

ENV SERVER_ROOT=/var/www/html
ENV SERVER_NAME=:80

EXPOSE 80

CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
