#!/bin/sh

retries=10
i=0
until mariadb -h mariadb -u${MYSQL_USER} -p${MYSQL_PASSWORD}; do
	if [ $i -gt $retries ]; then
		exit 1
	fi
	i=`expr $i + 1`
	echo retry $i
	sleep 1
done

i=0
until wp core is-installed; do
	if [ $i -gt $retries ]; then
		exit 1
	fi
	echo "[i] wp core config"
	wp core config  --dbname=$MYSQL_DATABASE \
					--dbhost=mariadb \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD --allow-root
	echo "[i] wp core install"
	wp core install --url=$DOMAIN_NAME \
					--title="WordPress" \
					--admin_user=$WP_ADMIN\
					--admin_password=$WP_ADMIN_PASS \
					--admin_email=$WP_ADMIN_EMAIL \
					--skip-email --allow-root
	echo "[i] wp user create"
	wp user create  $WP_USER $WP_USER_EMAIL \
					--user_pass=$WP_USER_PASS \
					--role=author --allow-root
	# echo "[i] install redis plugin"
	wp plugin install redis-cache --activate
	wp redis enable
	wp config set WP_REDIS_HOST redis
	wp config set WP_REDIS_PASSWORD $REDIS_PASS
	
	i=`expr $i + 1`
	echo retry $i
	sleep 1
done
echo "WordPress is installed!"

exec php-fpm7 --nodaemonize
