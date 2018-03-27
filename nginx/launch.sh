#!bin/bash
IP_ADDRESS=$(curl -s ifconfig.co)

envsubst $IP_ADDRESS < /etc/nginx/conf.d/nginx.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
