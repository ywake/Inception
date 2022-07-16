include srcs/.env

# YAML		:= srcs/docker-compose.yml
# COMPOSE		:= docker-compose -f $(YAML) --env-file srcs/.env
COMPOSE		:= cd srcs/ && docker-compose
SERVICES	:= srcs/requirements

VOLUMES		:= mysql redis certs
VOLUMES_DIR	:= $(addprefix $(DATA_PATH)/, $(VOLUMES))
WORDPRESS	:= $(DATA_PATH)/wordpress
WP_TAR		:= latest-ja.tar.gz
CERT_FILE	:= $(DATA_PATH)/certs/server.crt
CERT_KEY	:= $(DATA_PATH)/certs/server.key

HOSTS		:= /etc/hosts
HOSTS_BACKUP:= /etc/hosts.back

all: $(VOLUMES_DIR) $(HOSTS_BACKUP) $(CERT_KEY) $(CERT_FILE)
	$(COMPOSE) build $(SERV)
	$(COMPOSE) up -d

clean: FORCE
	-$(COMPOSE) down --rmi all --volumes

fclean: clean
# docker rmi $(shell docker images -q) -f
	$(RM) -r $(DATA_PATH) $(WP_TAR)
	-sudo mv -f $(HOSTS).back $(HOSTS)
	docker system prune

re: clean all

.PHONY: FORCE
FORCE:

$(HOSTS_BACKUP):
	sudo cp $(HOSTS) $@
	echo '127.0.0.1 $(DOMAIN_NAME)' | sudo tee -a $(HOSTS) || sudo $(RM) $@

$(DATA_PATH):
	mkdir -p $@

$(WP_TAR):
	curl https://ja.wordpress.org/latest-ja.tar.gz > $@

$(WORDPRESS): $(WP_TAR) $(DATA_PATH)
	tar -xzf $< -C $(DATA_PATH)

$(CERT_KEY):
	openssl genrsa -out $(CERT_KEY) 2048

$(CERT_FILE):
	openssl req -new -key $(CERT_KEY) -out $(DATA_PATH)/certs/server.csr -subj "/C=JP/ST=Tokyo/L=Tokyo/O=ywake/OU=Web" &&\
	openssl x509 -in $(DATA_PATH)/certs/server.csr -days 3650 -req -signkey $(CERT_KEY) > $(CERT_FILE)

$(VOLUMES_DIR): $(DATA_PATH) $(WORDPRESS)
	mkdir -p $@

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


