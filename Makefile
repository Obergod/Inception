DOCKER_USERNAME ?= mafioron
APPLICATION_NAME ?= Inception

all: up

setup:
	sudo mkdir -p /home/mafioron/data/mariadb
	sudo mkdir -p /home/mafioron/data/wordpress
	sudo chmod 777 /home/mafioron/data/mariadb
	sudo chmod 777 /home/mafioron/data/wordpress
	@echo "$(GREEN)Setup complete!$(RESET)"


up: setup
	docker-compose -f ./srcs/docker-compose.yml up -d

build:
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

check:
	docker-compose ps -f ./srcs/docker-compose.yml

logs:
	docker logs mariadb
	docker logs wordpress
	docker logs nginx

clean:
	sudo docker system prune -af

fclean: down
	docker volume rm srcs_db-data srcs_wp-data 2>/dev/null
	sudo rm -rf /home/mafioron/data/mariadb/*
	sudo rm -rf /home/mafioron/data/wordpress/*
	sudo docker system prune -af
re:
	fclean all

.PHONY: all setup up down clean fclean re
