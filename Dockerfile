# You can change this to a different version of Wordpress available at
# https://hub.docker.com/_/wordpress
FROM wordpress:6.8.2-php8.1-apache

# Install minimal packages needed for Render deployment
RUN apt-get update && apt-get install -y \
    unzip \
    magic-wormhole \
    && rm -rf /var/lib/apt/lists/*

# Install essential PHP extensions for WordPress performance
RUN docker-php-ext-install opcache

# Install WP-CLI for WordPress management (useful for deployments)
RUN curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/v2.10.0/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy database test file
COPY db-test.php /var/www/html/

RUN usermod -s /bin/bash www-data
RUN chown www-data:www-data /var/www
USER www-data:www-data
