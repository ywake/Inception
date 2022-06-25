FROM alpine:3.15

# RUN apk --no-cache --update add mariadb mariadb-client
RUN apk --no-cache --update add openrc mariadb mariadb-client
RUN rc-status && touch /run/openrc/softlevel

COPY setup.sh /tmp/setup.sh

CMD [ "sh", "/tmp/setup.sh" ]
