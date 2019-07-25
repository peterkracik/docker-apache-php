FROM php:7.3-fpm

RUN apt-get update && apt-get upgrade -yy && apt-get install sendmail apache2 libjpeg-dev libpng-dev libzip-dev libfreetype6-dev supervisor zip unzip software-properties-common -yy
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

# # # APACHE 
COPY site.conf /etc/apache2/sites-enabled/000-default.conf
RUN a2enmod deflate proxy proxy_fcgi rewrite

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install mbstring gd mysqli pdo pdo_mysql


COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]