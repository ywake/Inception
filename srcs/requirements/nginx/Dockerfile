FROM alpine:3.14

RUN	apk update &&\
	apk add nginx openssl &&\
	adduser -D -g 'www' www &&\
	mkdir /www &&\
	chown -R www:www /var/lib/nginx &&\
	chown -R www:www /www

COPY --chown=www:www nginx.conf /etc/nginx/nginx.conf
COPY --chown=www:www default.conf /etc/nginx/http.d/default.conf
COPY --chown=www:www index.html /www/index.html

RUN	mkdir /etc/nginx/ssl && cd /etc/nginx/ssl &&\
	openssl genrsa -out server.key 2048 && \
	openssl req -new -key server.key -out server.csr -subj '/C=JP/ST=Tokyo/L=Tokyo/O=ywake/OU=Web/CN=localhost' &&\
	openssl x509 -in server.csr -days 3650 -req -signkey server.key > server.crt

RUN	mkdir /etc/ssl/nginx &&\
	openssl dhparam -out /etc/ssl/nginx/dh2048.pem 2048

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
