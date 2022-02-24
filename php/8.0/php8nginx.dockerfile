FROM ubuntu:latest
MAINTAINER Bruno Fonseca
RUN apt update && apt -y upgrade
RUN apt install -y ca-certificates apt-transport-https software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt install -y php8.0-fpm php8.0-mysql php8.0-pgsql php8.0-mbstring
RUN apt update -y
RUN apt install -y php-sodium php-curl php8.0-dom git
RUN apt install -y nginx
RUN rm -rf /var/www/html
RUN mkdir /var/www/public
RUN chmod 755 -R /var/www/public
COPY php.ini  /etc/php/8.0/fpm
COPY index.php /var/www/public
COPY nginx/default /etc/nginx/sites-available
COPY nginx/nginx.conf /etc/nginx
RUN systemctl enable php8.0-fpm.service
RUN apt install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
EXPOSE 80 443
CMD ["/usr/bin/supervisord"]