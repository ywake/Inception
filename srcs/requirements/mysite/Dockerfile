FROM alpine:3.15

RUN apk add --no-cache --update tini curl unit

COPY ./config.json /tmp/config.json

RUN mkdir -p /var/www/html
# COPY index.html /var/www/html/

RUN unitd && \
	curl -X PUT --data-binary @/tmp/config.json --unix-socket /run/control.unit.sock http://localhost/config

ENTRYPOINT ["tini", "-vv", "--"]
CMD [ "unitd", "--no-daemon", "--log", "/dev/stdout" ]
