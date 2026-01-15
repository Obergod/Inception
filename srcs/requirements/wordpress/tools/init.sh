#! /bin/bash

DB_PASSWORD=$( cat /run/secrets/db_password )

sleep 5

echo "mariadb is ready"

cd /var/www/html

mkdir -p /run/php

if [ ! -f wp-config.php ]; then
	echo "configuring worpress"

	wp config create \
		--dbname="${WORDPRESS_DB_NAME}" \
		--dbuser="${WORDPRESS_DB_USER}" \
		--dbpass="${DB_PASSWORD}" \
		--dbhost="${WORDPRESS_DB_HOST}" \
		--allow-root

	wp core install \
		--url=https://mafioron.42.fr \
		--title=Inception \
		--admin_user="mafioron" \
		--admin_password="real_pass" \
		--admin_email="mafioron@student.42.fr" \
		--allow-root
	
	wp user create Alain Alain@42.fr \
		--role=editor \
		--user_pass="Alain_pass" \
		--allow-root
fi

exec php-fpm7.4 -F
