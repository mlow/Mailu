#!/bin/sh
stop() {
  pkill php-fpm7
  pkill nginx
  exit
}

trap stop SIGTERM SIGINT SIGQUIT SIGHUP

start() {
  chown nginx:nobody /var/lib/z-push /var/log/z-push
  chmod 770 /var/lib/z-push /var/log/z-push
  php-fpm7
  nginx -g 'daemon off;'
}

start &
wait
