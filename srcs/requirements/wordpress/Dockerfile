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
	
RUN mkdir -p /var/www/html

RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	mv wordpress/* /var/www/html && \
	rm -rf latest.tar.gz wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY tools/init.sh /usr/local/bin/
COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./conf/www.cnf /etc/mysql/conf.d/www.cnf

RUN chmod +x /usr/local/bin/init.sh
RUN chmod +x /var/www/html/wp-config.php
RUN chmod +x /etc/mysql/conf.d/www.cnf

EXPOSE 9000

CMD ["init.sh"]
