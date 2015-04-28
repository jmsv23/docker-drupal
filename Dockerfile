FROM phusion/baseimage:0.9.15
MAINTAINER Jose M. Santibanez <jmsv23@gmail.com>
 
ENV HOME /root
ADD ./sh/start.sh /start.sh
 
RUN apt-get update -q

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN echo 'root:$6$l/PahbyY$jFhqIAuvHeK/GwjfT71p4OBBkHQpnTe2FErcUWZ8GIN1ykdI7CgL05Jkk7MYW6l.0pijAlfoifkQnLpaldEJY0' | chpasswd -e

COPY ssh/id_rsa.pub $HOME/.ssh/authorized_keys
COPY ssh/sshd_config /etc/ssh/sshd_config
#RUN service ssh restart

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

 
EXPOSE 22
EXPOSE 80

#RUN service php5-fpm restart
#RUN service nginx start
#RUN update-rc.d nginx defaults
#RUN update-rc.d php5-fpm defaults
RUN chmod 755 /start.sh
 
#CMD ["/sbin/my_init"]
CMD ["/bin/bash","/start.sh"]