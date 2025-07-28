#!/bin/bash

# WordPress initialization script
echo "🔧 Initializing WordPress..."

# Run the original WordPress docker entrypoint script to set up wp-config.php
if [ -f "/usr/local/bin/docker-entrypoint.sh" ]; then
    echo "📝 Running WordPress entrypoint..."
    /usr/local/bin/docker-entrypoint.sh 'true' || true
fi

# Ensure WordPress files are in place
if [ ! -f "/var/www/html/index.php" ]; then
    echo "📦 Copying WordPress files..."
    if [ -d "/usr/src/wordpress" ]; then
        cp -R /usr/src/wordpress/* /var/www/html/
    fi
fi

# Create wp-config.php if it doesn't exist
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "⚙️ Creating wp-config.php..."
    
    # Set environment variable defaults
    export WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST:-localhost}
    export WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME:-wordpress}
    export WORDPRESS_DB_USER=${WORDPRESS_DB_USER:-wordpress}
    export WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD:-wordpress_password}
    
    # Create a basic wp-config.php
    cat > /var/www/html/wp-config.php << 'EOF'
<?php
define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') ?: 'wordpress' );
define( 'DB_USER', getenv('WORDPRESS_DB_USER') ?: 'wordpress' );
define( 'DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') ?: 'wordpress_password' );
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'localhost' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

define( 'AUTH_KEY',         getenv('WORDPRESS_AUTH_KEY') ?: 'put your unique phrase here' );
define( 'SECURE_AUTH_KEY',  getenv('WORDPRESS_SECURE_AUTH_KEY') ?: 'put your unique phrase here' );
define( 'LOGGED_IN_KEY',    getenv('WORDPRESS_LOGGED_IN_KEY') ?: 'put your unique phrase here' );
define( 'NONCE_KEY',        getenv('WORDPRESS_NONCE_KEY') ?: 'put your unique phrase here' );
define( 'AUTH_SALT',        getenv('WORDPRESS_AUTH_SALT') ?: 'put your unique phrase here' );
define( 'SECURE_AUTH_SALT', getenv('WORDPRESS_SECURE_AUTH_SALT') ?: 'put your unique phrase here' );
define( 'LOGGED_IN_SALT',   getenv('WORDPRESS_LOGGED_IN_SALT') ?: 'put your unique phrase here' );
define( 'NONCE_SALT',       getenv('WORDPRESS_NONCE_SALT') ?: 'put your unique phrase here' );

$table_prefix = getenv('WORDPRESS_TABLE_PREFIX') ?: 'wp_';

define( 'WP_DEBUG', getenv('WORDPRESS_DEBUG') === 'true' );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF
fi

# Set proper permissions
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

echo "✅ WordPress initialization complete"
