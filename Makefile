DOCKER_USERNAME ?= mafioron
APPLICATION_NAME ?= Inception

all: up

setup:
	mkdir -p /home/mafioron/data/mariadb
	mkdir -p /home/mafioron/data/wordpress

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

check:
	docker-compose ps

logs:
	docker-compose logs db
	docker-compose logs wordpress

clean:
	down

fclean: clean
	mkdir -rf /home/mafioron/data/mariadb
	mkdir -rf /home/mafioron/data/wordpress

.PHONY: all setup up down clean fclean re
