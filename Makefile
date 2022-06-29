YAML		:= srcs/docker-compose.yml
COMPOSE		:= docker-compose -f $(YAML)
DF_SRC		:= srcs/requirements
DATA_PATH	:= srcs/data/
WORDPRESS	:= $(DATA_PATH)/wordpress/
DB			:= $(DATA_PATH)/mysql/
WP_TAR		:= latest-ja.tar.gz

all: $(WORDPRESS) $(DB)
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

up:
	$(COMPOSE) up -d

exec:
	$(COMPOSE) exec $(SERV) sh

log:
	$(COMPOSE) logs -f $(SERV)

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

$(WP_TAR):
	curl https://ja.wordpress.org/latest-ja.tar.gz > $@

$(WORDPRESS): $(WP_TAR)
	tar -xzf $< -C $(DATA_PATH)
	cp $(DF_SRC)/wordpress/wp-config.php $(WORDPRESS)

$(DB):
	mkdir -p $(DB)
