FROM alpine:3.15

RUN	apk --no-cache --update add tini php7-fpm php7-mysqli php7-gd php7-mbstring php7-xml php7 php7-phar php7-openssl php-curl php7-tokenizer php7-json mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
	&& chmod +x wp-cli.phar\
	&& mv wp-cli.phar /usr/local/bin/wp

COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY setup.sh /tmp/setup.sh

WORKDIR /var/www/html/
ENTRYPOINT ["tini", "-vv", "--"]
CMD [ "sh", "/tmp/setup.sh" ]
