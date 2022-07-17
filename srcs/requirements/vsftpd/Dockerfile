FROM alpine:3.15

RUN apk add --no-cache --update tini vsftpd lftp

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./setup.sh /tmp/setup.sh

ENTRYPOINT ["tini", "-vv", "--"]
CMD [ "sh", "/tmp/setup.sh" ]
