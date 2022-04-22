DF_SRC		:= srcs/requirements
DF_NGINX	:= $(DF_SRC)/nginx


nginx: 
	docker build -t nginx $(DF_NGINX)
	docker run -d -p 80:80 nginx
