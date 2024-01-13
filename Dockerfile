# Stage 1: Composer Install
FROM composer:latest as composer
WORKDIR /app
COPY . /app
RUN composer install --ignore-platform-reqs --no-scripts

# Stage 2: PHP and Nginx
FROM php:8.2-fpm-alpine as production
WORKDIR /app

# Copy vendor directory from the composer stage
COPY --from=composer /app/vendor /app/vendor

# Copy the rest of the application
COPY . /app

# Set up environment variables
ENV APP_ENV=production
ENV APP_KEY=asdfasdfasdfadf

# Run any additional commands, e.g., migrations
#RUN php artisan migrate --force

# Expose the port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
