#!/bin/bash

# Start MySQL and setup database
echo "🚀 Starting MySQL with database setup..."

# Start MySQL in background
/usr/bin/mysqld_safe --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid &
MYSQL_PID=$!

# Wait for MySQL to be ready and run setup
/app/scripts/setup-database.sh

# Keep MySQL running in foreground
wait $MYSQL_PID
