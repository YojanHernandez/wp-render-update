#!/bin/bash

# Simple MySQL setup for WordPress
echo "🔧 Setting up MySQL for WordPress..."

# Get environment variables with secure defaults
DB_NAME=${WORDPRESS_DB_NAME:-wordpress}
DB_USER=${WORDPRESS_DB_USER:-wordpress}
DB_PASSWORD=${WORDPRESS_DB_PASSWORD:-wordpress_password}

# Wait for MySQL to start
until mysqladmin ping -h localhost --silent; do
    echo "⏳ Waiting for MySQL..."
    sleep 3
done

echo "✅ MySQL is running"

# Check if database setup already exists
if mysql -e "USE $DB_NAME" 2>/dev/null; then
    echo "✅ Database '$DB_NAME' already exists"
else
    echo "🏗️ Creating database and user..."
    # Create database and user if they don't exist
    mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>/dev/null
    mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';" 2>/dev/null
    mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';" 2>/dev/null
    mysql -e "FLUSH PRIVILEGES;" 2>/dev/null
    echo "✅ Database '$DB_NAME' ready for WordPress"
fi
