FROM alpine:3.15

RUN apk add --no-cache --update tini curl unit unit-php7 php7-mysqli php7-session

COPY ./config.json /tmp/config.json

RUN mkdir -p /var/www/html && \
	curl -L -o /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

RUN unitd && \
	curl -X PUT --data-binary @/tmp/config.json --unix-socket /run/control.unit.sock http://localhost/config

ENTRYPOINT ["tini", "-vv", "--"]
CMD [ "unitd", "--no-daemon", "--log", "/dev/stdout" ]
