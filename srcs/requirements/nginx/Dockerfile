FROM alpine:3.14

RUN	apk update &&\
	apk add nginx &&\
	adduser -D -g 'www' www &&\
	mkdir /www &&\
	chown -R www:www /var/lib/nginx &&\
	chown -R www:www /www

COPY --chown=www:www nginx.conf /etc/nginx/nginx.conf
COPY --chown=www:www index.html /www/index.html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
