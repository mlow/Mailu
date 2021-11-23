ARG NGINX_VERSION=1.21

FROM nginx:${NGINX_VERSION}-alpine

ARG ZPUSH_URL=https://github.com/Z-Hub/Z-Push/archive/refs/tags/2.6.4.tar.gz
ARG AWL_URL=https://gitlab.com/davical-project/awl/-/archive/r0.62/awl-r0.62.tar.gz

# Install z-push and dependencies
RUN apk add --update --no-cache \
    php7 \
    php7-curl \
    php7-dom \
    php7-fpm \
    php7-mbstring \
    php7-iconv \
    php7-imap \
    php7-posix \
    php7-pdo \
    php7-simplexml \
    php7-xmlwriter \
    php7-sysvshm \
    php7-sysvsem \
    php7-xsl \
  && mkdir /usr/share/awl /tmp/z-push \
  && wget -O /tmp/z-push.tgz ${ZPUSH_URL} \
  && tar -xzf /tmp/z-push.tgz --strip-components 1 -C /tmp/z-push \
  && mv /tmp/z-push/src /usr/share/z-push \
  && rm -rf /tmp/z-push.tgz /tmp/z-push \
  && wget -O- ${AWL_URL} \
      | tar -xzf- --strip-components 1 -C /usr/share/awl \
  && chown -R nginx:nobody /usr/share/awl /usr/share/z-push

COPY config.php /usr/share/z-push/config.php
COPY imap_config.php /usr/share/z-push/backend/imap/config.php
COPY autodiscover_config.php /usr/share/z-push/autodiscover/config.php
COPY combined_config.php /usr/share/z-push/backend/combined/config.php
COPY caldav_config.php /usr/share/z-push/backend/caldav/config.php
COPY carddav_config.php /usr/share/z-push/backend/carddav/config.php

COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY start.sh .

VOLUME ["/var/lib/z-push", "/var/log/z-push"]

EXPOSE 80/tcp

CMD ["./start.sh"]
