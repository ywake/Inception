#!/bin/sh -e

if [ -d /var/lib/mysql/mysql ]; then
	echo "[i] MySQL directory already present, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
	echo "[i] MySQL data directory not found, creating initial DBs"
	rc-service mariadb setup
fi

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
	echo "[i] ${MYSQL_DATABASE} data directory not found, setup DBs"
	rc-service mariadb start
	mysql -u root <<EOF
DROP DATABASE test;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root';
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL ON *.* TO 'root'@'%';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
service mariadb stop
fi

echo
echo 'MySQL init process done. Ready for start up.'
echo

exec /usr/bin/mysqld_safe -u mysql

# select user(); // whoami
# show grants for root@'localhost';
