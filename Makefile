YAML		:= srcs/docker-compose.yml
COMPOSE		:= docker-compose -f $(YAML)
DF_SRC		:= srcs/requirements
WORDPRESS	:= $(DF_SRC)/wordpress/wp-src
WP_TAR		:= $(DF_SRC)/wordpress/latest-ja.tar.gz

all: #$(WORDPRESS)
ifdef SERV
	$(COMPOSE) stop $(SERV)
	docker rmi -f $(SERV)
endif
	$(COMPOSE) build $(SERV)
	$(COMPOSE) up -d

clean:
	$(COMPOSE) down --rmi all --volumes

fclean:
	$(COMPOSE) down --rmi all --volumes
# docker rmi $(shell docker images -q) -f
# $(RM) -r $(WORDPRESS) $(WP_TAR)

re: fclean all

#####
# compose commands
#####

exec:
	$(COMPOSE) exec $(SERV) sh

log:
	$(COMPOSE) logs

cmd:
	$(COMPOSE) $(CMD)

#####
# services
#####

nginx: 
# docker build -t nginx $(DF_SRC)/nginx
	docker run -p 8080:80 -p 443:443 nginx

wp: #$(WORDPRESS)
	docker build -t wordpress $(DF_SRC)/wordpress
	docker run -it wordpress sh

# $(WP_TAR):
# 	curl https://ja.wordpress.org/latest-ja.tar.gz > $@

# $(WORDPRESS): $(WP_TAR)
# 	tar -xzf $< -C $(WORDPRESS)
