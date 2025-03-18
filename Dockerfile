FROM php:8.1-cli


RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

WORKDIR /app

COPY --chown=www-data:www-data composer.json composer.lock symfony.lock ./
COPY --chown=www-data:www-data vendor/ vendor/

COPY . .

RUN curl -Ls https://github.com/roadrunner-server/roadrunner/releases/latest/download/roadrunner-linux-amd64 -o /usr/local/bin/rr \
    && chmod +x /usr/local/bin/rr

EXPOSE 8080
CMD ["rr", "serve"]
