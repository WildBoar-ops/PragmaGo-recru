FROM php:8.1-cli

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer require baldinof/roadrunner-bundle || composer update --lock
COPY composer.json composer.lock symfony.lock ./
RUN composer install

# Copy the entire project
COPY . .

RUN curl -Ls https://github.com/roadrunner-server/roadrunner/releases/latest/download/roadrunner-linux-amd64 -o /usr/local/bin/rr \
    && chmod +x /usr/local/bin/rr

EXPOSE 8080
CMD ["rr", "serve"]
