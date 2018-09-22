FROM php:7.1-fpm-alpine
ADD https://getcomposer.org/installer /tmp/composer-install
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini

RUN /usr/bin/env php /tmp/composer-install --install-dir=/usr/local/bin --filename=composer \
    && rm /tmp/composer-install \
    && apk update \
    && apk add postgresql-dev \
    && docker-php-source extract \
    && docker-php-ext-install pdo pdo_pgsql \
    && docker-php-source delete \
    && adduser -D -u 1000 -g users docker \
    && mkdir -p /var/lib/php/sessions/ \
    && chown docker:users /var/lib/php/sessions \
    && chmod -R 0755 /var/lib/php/sessions


WORKDIR /var/www
USER docker:www-data