FROM php:8.1-cli

RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip
# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
# Set dir
WORKDIR /app
# Copy code
COPY . .
# Install PHP dependencies
RUN composer install
# Install RoadRunner
RUN curl -SSL https://github.com/spiral/roadrunner/releases/latest/download/roadrunner.phar -o /usr/local/bin/rr \
    && chmod +x /usr/local/bin/rr
# Run RoadRunner
CMD ["rr", "serve"]
