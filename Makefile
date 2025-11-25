DOCKER_USERNAME ?= mafioron
APPLICATION_NAME ?= Inception

all: up

setup:
	sudo mkdir -p /home/mafioron/data/mariadb
	sudo mkdir -p /home/mafioron/data/wordpress
	sudo chmod 777 /home/mafioron/data/mariadb
	sudo chmod 777 /home/mafioron/data/wordpress

up: setup
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

check:
	docker compose ps

logs:
	docker compose logs db
	docker compose logs wordpress

clean:
	sudo docker system prune -af

fclean: clean
	sudo rm -rf /home/mafioron/data/mariadb/*
	sudo rm -rf /home/mafioron/data/wordpress/*

.PHONY: all setup up down clean fclean re
