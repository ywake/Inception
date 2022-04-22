DF_SRC		:= srcs/requirements
DF_NGINX	:= $(DF_SRC)/nginx
YAML		:= srcs/docker-compose.yml

all:
	docker-compose -f $(YAML) up -d

clean:
	docker-compose -f $(YAML) down

fclean:
	docker-compose -f $(YAML) down --rmi all --volumes 

re: fclean all

nginx: 
	docker build -t nginx $(DF_NGINX)
	docker run -d -p 80:80 -p 443:443 nginx
