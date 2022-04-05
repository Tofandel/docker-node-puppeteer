FROM php:8.1.5RC1-cli-alpine

# Optional, force UTC as server time
RUN echo "UTC" > /etc/timezone

# Install essential build tools
RUN apk add --update --no-cache \
    g++ autoconf make \
    git bash \
    npm yarn \
#soap
  libxml2-dev \
#zip
  libzip-dev \
#phar
  openssl-dev \
#gd
  libpng-dev

#bzip2-dev

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer
    
# Preinstalled with
# ctype curl date dom fileinfo filter ftp hash
# iconv json libxml mbstring mysqlnd openssl
# pcre PDO pdo_sqlite Phar posix readline session
# SimpleXML sodium sqlite3 standard tokenizer
# xml xmlreader xmlwriter zlib

RUN docker-php-ext-install \
    pcntl posix \
    mysqli \
    zip \
    soap \
    shmop \
    phar \
    gd exif fileinfo \
    opcache 
    

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo 'xdebug.mode="coverage"' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN rm -rf /tmp/*
RUN apk del g++ autoconf make libxml2-dev libzip-dev openssl-dev libpng-dev

ENTRYPOINT ["/bin/bash", "-l", "-c"]
