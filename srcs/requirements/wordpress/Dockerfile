FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y \
	php-fpm \
	php-mysql \
	wget \
	curl \
	mariadb-client \
	tar && \
	rm -rf /var/lib/apt/lists/*
	
RUN mkdir -p /var/www/wordpress

RUN chown -R root:root /var/www/wordpress

RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	mv wordpress/* /var/www/wordpress && \
	rm -rf latest.tar.gz wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY tools/init.sh /usr/local/bin/
COPY ./conf/wp-config.php /var/www/wordpress/wp-config.php
#COPY ./conf/www.cnf /etc/mysql/conf.d/www.cnf
COPY ./conf/www.cnf /etc/php/7.4/fpm/pool.d/www.conf


RUN chmod +x /usr/local/bin/init.sh

EXPOSE 9000

CMD ["init.sh"]
