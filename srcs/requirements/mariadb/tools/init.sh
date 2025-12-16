#!/bin/bash

set -e

DB_PASSWORD=$( cat /run/secrets/db_password )
ROOT_PASSWORD=$( cat /run/secrets/db_root_password )

mkdir -p /run/mysqld && \
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
	echo "Initalizing MariaDB";

	mysql_install_db --user=mysql --datadir=/var/lib/mysql;
	
	mysqld --user=mysql --bootstrap << EOF
	FLUSH PRIVILEGES;
	CREATE DATABASE IF NOT EXISTS `${MYSQL_DATABASE}`;
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
	GRANT ALL PRIVILEGES ON `${MYSQL_DATABASE}`.* TO '${MYSQL_USER}'@'%';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	FLUSH PRIVILEGES;
EOF

fi



exec mysqld --user=mysql --console
