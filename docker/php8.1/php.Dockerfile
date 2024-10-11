FROM php:8.1-fpm

# Set the working directory inside the container
WORKDIR /app

# Install Shopify CLI dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gcc \
    g++ \
    make \
    build-essential \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libffi-dev \
    autoconf \
    libncurses5-dev \
    bison \
    libgdbm-dev \
    git \
    lsof \
    socat \
    software-properties-common \
    default-libmysqlclient-dev \
    libpq-dev \
    unzip \
    imagemagick \
    sudo \
    libzip-dev \
    xdg-utils \
         && docker-php-ext-install zip

# InstallX-debug
RUN set -x \
    && pecl install -f xdebug-3.0.0 \
    && docker-php-ext-enable xdebug

#Install PDO (need for composer laravel)
RUN docker-php-ext-install pdo pdo_mysql

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
RUN apt install nodejs

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn --yes

# install composer

RUN curl -sS https://getcomposer.org/installer | \
  php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir -p /home/appuser/.config/shopify && chmod -R 777 /home/appuser/.config/shopify



# Expose port 9000 and start php-fpm server
EXPOSE 9000

CMD ["php-fpm"]
