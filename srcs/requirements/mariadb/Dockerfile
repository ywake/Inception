FROM alpine:3.15

# RUN apk --no-cache --update add mariadb mariadb-client
RUN apk --no-cache --update add tini openrc mariadb mariadb-client
RUN rc-status && touch /run/openrc/softlevel

COPY setup.sh /tmp/setup.sh
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

ENTRYPOINT ["tini", "-vv", "--"]
CMD [ "sh", "/tmp/setup.sh" ]
