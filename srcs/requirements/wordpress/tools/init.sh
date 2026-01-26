#! /bin/bash

DB_PASSWORD=$(tr -d '\n' < /run/secrets/db_password)
ADMIN_PASSWORD=$(tr -d '\n' < /run/secrets/admin_password)


echo "Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h"${WORDPRESS_DB_HOST%%:*}" --silent 2>/dev/null; do
    sleep 2
done

echo "mariadb is ready"

cd /var/www/wordpress

mkdir -p /run/php
mkdir -p /var/www/wordpress/wp-content/uploads
chown -R www-data:www-data /var/www/wordpress/wp-content

if [ ! -f /var/www/wordpress/wp-config.php ]; then
	echo "configuring wordpress"

	wp config create \
		--dbname="${WORDPRESS_DB_NAME}" \
		--dbuser="${WORDPRESS_DB_USER}" \
		--dbpass="${DB_PASSWORD}" \
		--dbhost="${WORDPRESS_DB_HOST}" \
		--allow-root
fi

if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then

	echo "core install wordpress"

	wp core install \
		--url=https://mafioron.42.fr \
		--title=Inception \
		--admin_user="${ADMIN_USER}" \
		--admin_password="${ADMIN_PASSWORD}" \
		--admin_email="${ADMIN_EMAIL}" \
		--allow-root
	
	wp user create Alain Alain@42.fr \
		--role=editor \
		--user_pass="${USER_PASS}" \
		--allow-root
fi

echo "Wordpress configured"

exec php-fpm8.2 -F
