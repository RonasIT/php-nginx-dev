FROM webdevops/php-nginx-dev:8.1-alpine
USER root

# Install necessary build tools and headers
RUN apk add --no-cache autoconf g++ make linux-headers

RUN pecl uninstall xdebug \
    && rm -rf /usr/local/lib/php/extensions/no-debug-non-zts-*/xdebug.so \
    && rm -rf /usr/local/lib/php/extensions/no-debug-non-zts-*/xdebug.so.debug

RUN pecl install xdebug-3.2.2 \
    && docker-php-ext-enable xdebug