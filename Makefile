include srcs/.env

# YAML		:= srcs/docker-compose.yml
# COMPOSE		:= docker-compose -f $(YAML) --env-file srcs/.env
COMPOSE		:= cd srcs/ && docker-compose
SERVICES	:= srcs/requirements

VOLUMES		:= mysql redis
VOLUMES_DIR	:= $(addprefix $(DATA_PATH)/, $(VOLUMES))
WORDPRESS	:= $(DATA_PATH)/wordpress
WP_TAR		:= latest-ja.tar.gz

HOSTS		:= /etc/hosts

all: $(VOLUMES_DIR) $(HOSTS).back
# ifdef SERV
# 	$(COMPOSE) rm $(SERV)
# endif
	$(COMPOSE) build $(SERV)
	$(COMPOSE) up -d

clean: FORCE
	-$(COMPOSE) down --rmi all --volumes

fclean: clean
# docker rmi $(shell docker images -q) -f
	sudo $(RM) -r $(DATA_PATH) $(WP_TAR)
	-sudo mv -f $(HOSTS).back $(HOSTS)
	docker system prune

re: clean all

.PHONY: FORCE
FORCE:

$(HOSTS).back:
	sudo cp $(HOSTS) $@
	echo '127.0.0.1 $(DOMAIN_NAME)' | sudo tee -a $(HOSTS) || sudo $(RM) $@

$(DATA_PATH):
	sudo mkdir -p $@

$(WP_TAR):
	curl https://ja.wordpress.org/latest-ja.tar.gz > $@

$(WORDPRESS): $(WP_TAR) $(DATA_PATH)
	sudo tar -xzf $< -C $(DATA_PATH)

$(VOLUMES_DIR): $(DATA_PATH) $(WORDPRESS)
	sudo mkdir -p $@

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

# nginx: 
# # docker build -t nginx $(SERVICES)/nginx
# 	docker run -p 8080:80 -p 443:443 nginx

# wp: #$(WORDPRESS)
# 	docker build -t wordpress $(SERVICES)/wordpress
# 	docker run -it wordpress sh


