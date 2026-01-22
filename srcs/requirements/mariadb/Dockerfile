FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y \
	mariadb-server \
	mariadb-client && \
	rm -rf /var/lib/apt/lists/*

COPY tools/test.sh /usr/local/bin/
COPY conf/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf 

RUN chmod +x /usr/local/bin/test.sh
RUN chmod +x /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

CMD ["test.sh"]
