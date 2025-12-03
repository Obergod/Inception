FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y \
	php-fpm \
	php-mysql \
	wget \
	tar && \
	rm -rf /var/lib/apt/lists/*
	
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz


COPY 

EXPOSE 9000

CMD [""]
