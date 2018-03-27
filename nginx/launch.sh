#!bin/bash
#IP_ADDRESS=$(curl -s ifconfig.co)

envsubst  < /etc/nginx/conf.d/nginx.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
