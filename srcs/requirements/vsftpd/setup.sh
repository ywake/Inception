#!/bin/sh

adduser wordpress <<EOF
password
password
EOF

echo "wordpress" >> /etc/vsftpd.user_list

exec vsftpd /etc/vsftpd/vsftpd.conf
