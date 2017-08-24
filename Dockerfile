
FROM php:alpine

MAINTAINER jumeau.jeremy@gmail.com

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.composer/vendor/bin
ENV PHPCS_VERSION 3.0.2
ENV PHP_CS_FIXER_VERSION 2.5.0
ENV PHPMD_VERSION 2.6.0
ENV PHPUNIT_VERSION 6.3.0
ENV PHPLOC_VERSION 4.0.0

# bash
RUN apk add --no-cache bash

# composer
ENV COMPOSER_ALLOW_SUPERUSER 1
COPY composer-setup.sh /usr/local/bin/composer-setup
RUN composer-setup

# coke (includes phpcs & Symfony coding standard)
RUN composer global require \
    m6web/coke \
    m6web/Symfony2-coding-standard

# phpcs
# RUN curl -L \
#     https://github.com/squizlabs/PHP_CodeSniffer/releases/download/${PHPCS_VERSION}/phpcs.phar \
#     -o /usr/local/bin/phpcs \
#     && chmod a+x /usr/local/bin/phpcs

# php-cs-fixer
RUN curl -L \
    https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v${PHP_CS_FIXER_VERSION}/php-cs-fixer.phar \
    -o /usr/local/bin/php-cs-fixer \
    && chmod a+x /usr/local/bin/php-cs-fixer

# phpmd
RUN curl -L \
    http://static.phpmd.org/php/${PHPMD_VERSION}/phpmd.phar \
    -o /usr/local/bin/phpmd \
    && chmod a+x /usr/local/bin/phpmd

# phpunit
RUN curl -L \
    https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar \
    -o /usr/local/bin/phpunit \
    && chmod a+x /usr/local/bin/phpunit

# phploc
RUN curl -L \
    https://phar.phpunit.de/phploc-${PHPLOC_VERSION}.phar \
    -o /usr/local/bin/phploc \
    && chmod a+x /usr/local/bin/phploc
