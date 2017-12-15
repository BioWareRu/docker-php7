FROM php:7.1-alpine


RUN apk update \
    && apk add \
    tzdata \
    libmcrypt-dev \
    icu-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    autoconf \
    file \
    g++ \
    gcc \
    binutils \
    isl \
    libatomic \
    libc-dev \
    musl-dev \
    make \
    re2c \
    libstdc++ \
    libgcc \
    binutils-libs \
    mpc1 \
    mpfr3 \
    gmp \
    libgomp \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install mcrypt pdo_mysql intl zip opcache gd \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo "Europe/Moscow" >  /etc/timezone \
    && apk del \
    tzdata \
    libmcrypt-dev \
    icu-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    autoconf \
    file \
    g++ \
    gcc \
    binutils \
    isl \
    libatomic \
    libc-dev \
    musl-dev \
    make \
    re2c \
    libstdc++ \
    libgcc \
    binutils-libs \
    mpc1 \
    mpfr3 \
    gmp \
    libgomp \
    && rm -rf /var/cache/apk/* && rm -rf /tmp/* /var/tmp/*

COPY opcache.conf /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY php.ini /usr/local/etc/php/