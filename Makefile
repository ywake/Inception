YAML		:= srcs/docker-compose.yml
COMPOSE		:= docker-compose -f $(YAML)

all: #$(WORDPRESS)
	$(COMPOSE) down
	$(COMPOSE) build $(SERV)
	$(COMPOSE) up

clean:
	$(COMPOSE) down --rmi all --volumes

fclean:
	$(COMPOSE) down --rmi all --volumes
	docker rmi $(shell docker images -q) -f

re: fclean all

#####
# services
#####

exec:
	$(COMPOSE) exec $(SERV) sh

dc:
	docker-compose -f $(YAML) $(CMD)

nginx: 
# docker build -t nginx $(DF_SRC)/nginx
	docker run -p 8080:80 -p 443:443 nginx
