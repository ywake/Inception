FROM alpine:3.15

RUN	apk --no-cache --update add php7-fpm php7-mysqli php7-gd php7-mbstring php7-xml
RUN apk add php7 php7-phar php7-openssl php-curl php7-tokenizer php7-json

COPY www.conf /etc/php7/php-fpm.d/www.conf

CMD [ "php-fpm7", "--nodaemonize" ]
