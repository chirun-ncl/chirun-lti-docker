ARG VERSION=0.2-3
FROM php:8.0-apache

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends apt-utils apt-transport-https \
ca-certificates curl gnupg2 software-properties-common lsb-release sudo libyaml-dev rsync

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update -y && apt-get -y install docker-ce

RUN docker-php-ext-install pdo pdo_mysql
RUN pecl install yaml
COPY files/php/cblti.ini /usr/local/etc/php/conf.d/cblti.ini
COPY files/sudo/cblti /etc/sudoers.d/cblti
RUN chmod 440 /etc/sudoers.d/cblti

RUN curl -fsSL -o /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 && chmod +x /usr/bin/confd

RUN useradd -ms /bin/bash cblti && usermod -a -G www-data cblti

ARG VERSION
RUN git clone https://***REMOVED***@mas-gitlab.ncl.ac.uk/makecourse-tools/lti.git /srv/www/lti

RUN mkdir -p /srv/www/lti/upload
RUN chown -R cblti:cblti /srv/www/lti
RUN chown -R cblti:www-data /srv/www/lti/upload && chmod -R 775 /srv/www/lti/upload

COPY files/cblti/start.sh /cblti/start.sh
COPY files/cblti/index.html /srv/www/index.html
COPY files/cblti/apache/cblti80.conf.toml /etc/confd/conf.d/cblti80.conf.toml
COPY files/cblti/apache/cblti80.conf /etc/confd/templates/cblti80.conf
COPY files/cblti/apache/cblti443.conf.toml /etc/confd/conf.d/cblti443.conf.toml
COPY files/cblti/apache/cblti443.conf /etc/confd/templates/cblti443.conf
COPY files/cblti/apache/cblti.conf.toml /etc/confd/conf.d/cblti.conf.toml
COPY files/cblti/apache/cblti.conf /etc/confd/templates/cblti.conf
COPY files/cblti/config.php.toml /etc/confd/conf.d/config.php.toml
COPY files/cblti/config.php /etc/confd/templates/config.php
RUN a2dissite 000-default.conf && a2enmod rewrite ssl

CMD ["/bin/bash", "/cblti/start.sh"]
