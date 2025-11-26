#!/bin/bash

set -e

DB_PASSWORD=$( cat run/secrets/db_password.txt )
ROOT_PASSWORD=$( cat run/secrets/db_root_password.txt )

if [ ! -d /var/lib/mysql/mysql]; then
	echo "Initalizing MariaDB";

	mysql_install_db --user=mysql --datadir=data/lib/mysql;
	
	mysqld --user=mysql --bootstrap << EOF
	FLUSH PRIVILEGES
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
	GRANT ALL PRIVILEGES ON '${MYSQL_DATABASE}'.*@'%' TO '${MYSQL_USER}'@'%';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
	FLUSH PRIVILEGES
EOF

fi



exec mysqld --user=mysql
