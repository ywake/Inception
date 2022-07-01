FROM alpine:3.15

RUN	apk --no-cache --update add tini nginx openssl

# ssl
RUN	mkdir /etc/nginx/ssl && cd /etc/nginx/ssl &&\
	openssl genrsa -out server.key 2048 && \
	openssl req -new -key server.key -out server.csr -subj '/C=JP/ST=Tokyo/L=Tokyo/O=ywake/OU=Web/CN=localhost' &&\
	openssl x509 -in server.csr -days 3650 -req -signkey server.key > server.crt &&\
	mkdir /etc/ssl/nginx &&\
	openssl dhparam -out /etc/ssl/nginx/dh2048.pem 2048

COPY default.conf /etc/nginx/http.d/default.conf

ENTRYPOINT ["tini", "-vv", "--"]
CMD [ "nginx", "-g", "daemon off;" ]
