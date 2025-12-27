# FrankenPHP Base Image

Pre-built Docker base image for PHP applications using [FrankenPHP](https://frankenphp.dev/).

## Usage

```dockerfile
FROM composer:2 AS vendor

WORKDIR /app

COPY composer.json composer.json
COPY composer.lock composer.lock

RUN composer install --ignore-platform-reqs --no-interaction --no-plugins --no-scripts --prefer-dist

FROM ghcr.io/whilesmartphp/frankenphp:8.2

LABEL org.opencontainers.image.source=https://github.com/your-org/your-repo
LABEL org.opencontainers.image.description="Your project description"

COPY . /var/www/html
COPY --from=vendor /app/vendor/ /var/www/html/vendor/

RUN chown -R www-data:www-data /var/www/html /data /config

USER www-data
```

## What's Included

- Base: `dunglas/frankenphp:1-php{version}-alpine`
- PHP Extensions: pdo_mysql, mbstring, exif, pcntl, bcmath, gd, zip
- System packages: curl, libzip, libpng, libxml2, oniguruma, freetype, libjpeg-turbo
- PHP error logging configured to stderr (visible via `docker logs`)

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SERVER_ROOT` | `/var/www/html` | Document root |
| `SERVER_NAME` | `:80` | Server address |

### Laravel Projects

Laravel uses a `public` subdirectory as the document root. Override via Dockerfile:

```dockerfile
FROM ghcr.io/whilesmartphp/frankenphp:8.2

ENV SERVER_ROOT=/var/www/html/public
```

Or via docker-compose:

```yaml
services:
  app:
    image: ghcr.io/whilesmartphp/frankenphp:8.2
    environment:
      - SERVER_ROOT=/var/www/html/public
```

## Tags

| Tag | PHP Version |
|-----|-------------|
| `8.2` | PHP 8.2 |
| `8.3` | PHP 8.3 |
| `8.4`, `latest` | PHP 8.4 |
