FROM phusion/baseimage:0.9.15
MAINTAINER Jose M. Santibanez <jmsv23@gmail.com>
 
ENV HOME /root
ADD ./sh/start.sh /start.sh
 
RUN apt-get update -q

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

COPY ssh/id_rsa.pub $HOME/.ssh/authorized_keys
COPY ssh/sshd_config /etc/ssh/sshd_config

RUN apt-get install -y php-apc \
wget \
curl \
git \
php-pear \
php5-apcu \
php5-cli \
php5-common \
php5-curl \
php5-fpm \
php5-gd \
php5-json \
php5-mysql \
php5-readline \
nginx

COPY nginx/sites-available/default /etc/nginx/sites-available/default

WORKDIR /opt

RUN git clone https://github.com/drush-ops/drush.git
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

WORKDIR /opt/drush

RUN composer install
RUN ln -s /opt/drush/drush /usr/local/bin/drush
 
EXPOSE 22
EXPOSE 80

RUN chmod 755 /start.sh
 
CMD ["/bin/bash","/start.sh"]