#!/bin/bash
set -e

echo "Starting MariaDB initialization..."

DB_PASSWORD=$(cat /run/secrets/db_password)
ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

echo "Starting temporary MariaDB server..."
mysqld_safe --datadir=/var/lib/mysql --user=mysql &
pid="$!"

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done

echo "Running initial SQL setup..."
mysql -uroot <<-EOSQL
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
    DELETE FROM mysql.user WHERE User='';
    DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
    FLUSH PRIVILEGES;
EOSQL

echo "SQL setup complete!"

echo "Stopping temporary MariaDB server..."
mysqladmin -uroot -p"${ROOT_PASSWORD}" shutdown

wait "$pid" || true

fi

echo "Starting MariaDB in foreground..."
exec mysqld --user=mysql --console
