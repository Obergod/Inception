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

down:
	docker-compose -f ./srcs/docker-compose.yml down

check:
	docker-compose ps -f

logs:
	docker-compose logs mariadb
	docker-compose logs wordpress

clean:
	sudo docker system prune -af

fclean: clean
	sudo rm -rf /home/mafioron/data/mariadb/*
	sudo rm -rf /home/mafioron/data/wordpress/*

re:
	fclean all

.PHONY: all setup up down clean fclean re
