FROM alpine:3.15

RUN apk --no-cache --update add tini redis

RUN chown -R redis:redis /var/lib/redis
COPY redis.conf /etc/redis/redis.conf
COPY run.sh /tmp/run.sh

ENTRYPOINT ["tini", "-vv", "--"]
CMD [ "sh", "/tmp/run.sh" ]
