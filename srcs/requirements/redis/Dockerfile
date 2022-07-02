FROM alpine:3.15

RUN apk --no-cache --update add tini redis

RUN mkdir -p /data &&\
	chown -R redis:redis /data
COPY redis.conf /etc/redis.conf
COPY run.sh /tmp/run.sh

ENTRYPOINT ["tini", "-vv", "--"]
CMD [ "sh", "/tmp/run.sh" ]
