FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y \
	mariadb-server \
	mariadb-client && \
	rm -rf /var/lib/apt/lists/*

COPY tools/init.sh /usr/local/bin/
COPY conf/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf 

RUN chmod +x /usr/local/bin/init.sh

EXPOSE 3306

CMD ["init.sh"]
