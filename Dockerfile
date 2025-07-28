# WordPress with integrated MySQL - Simplified Single Configuration
FROM wordpress:6.8.2-php8.1-apache

# Install MySQL server and supervisor
RUN apt-get update && apt-get install -y \
    default-mysql-server \
    default-mysql-client \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Install essential PHP extensions
RUN docker-php-ext-install mysqli pdo_mysql

# Create directories and set permissions
RUN mkdir -p /var/run/mysqld /app/scripts /var/lib/mysql \
    && chown mysql:mysql /var/run/mysqld /var/lib/mysql \
    && chmod 755 /var/run/mysqld

# Initialize MySQL database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copy configuration files
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/mysql.cnf /etc/mysql/conf.d/wordpress.cnf
COPY scripts/setup-database.sh /app/scripts/setup-database.sh

# Make scripts executable
RUN chmod +x /app/scripts/setup-database.sh

# Expose port
EXPOSE 80

# Start supervisor to manage both Apache and MySQL
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
