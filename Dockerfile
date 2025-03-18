FROM php:8.1-cli


RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY composer.json composer.lock symfony.lock ./
RUN composer update --lock
RUN composer install

COPY . .

RUN curl -Ls https://github.com/roadrunner-server/roadrunner/releases/latest/download/roadrunner-linux-amd64 -o /usr/local/bin/rr \
    && chmod +x /usr/local/bin/rr

EXPOSE 8080
CMD ["rr", "serve"]
