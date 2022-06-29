FROM alpine:3.15

RUN	apk --no-cache --update add tini php7-fpm php7-mysqli php7-gd php7-mbstring php7-xml php7 php7-phar php7-openssl php-curl php7-tokenizer php7-json mariadb-client

COPY www.conf /etc/php7/php-fpm.d/www.conf

ENTRYPOINT ["tini", "-vvv", "--"]
CMD [ "php-fpm7", "--nodaemonize" ]
