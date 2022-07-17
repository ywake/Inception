#!/bin/sh

adduser ftp-user <<EOF
password
password
EOF

echo "ftp-user" >> /etc/vsftpd.user_list

exec vsftpd
