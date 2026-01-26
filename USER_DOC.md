## This document will help user or administrator understand main points or usage of this project.

### 1. So Inception is a project about docker-compose and the services, that can be installed with its help. In my example. So, wordpress is open source content management platform used for creating websites, blog sites and even apps. And goal of this project is to create stable Wordpress site, using MariaDB as database and nginx as web server.

### 2. I provided a Makefile that will help a user or administartor to easily start or stop the project. Use *make*,  to start the project *make build* to rebuild the project. *make fclean* to removes the volumes and files and *make down* to stop it.

### 3. To access my wordpress site, go to Virtual Machine and go to Firefox. Insert my site's adress and you are connected ! To access admin page of my wordpress page, add */wp-admin/* to my site page mafioron.42.fr.

### 4. You will need .env file to be able to run this project. Use command *cp /home/env/.env .home/Inception/secrets

### 5. To check taht all services are working, you can use command *docker ps*. But if you want to go to bash of my containers, use *docker exec name_of_container it bash*.
