FROM webdevops/php-nginx-dev:8.3-alpine
RUN echo memory_limit = -1 >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;