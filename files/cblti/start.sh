#!/bin/bash

export CBLTI_ADMIN_EMAIL=${CBLTI_ADMIN_EMAIL:-"admin@localhost"}
export CBLTI_SERVERNAME=${CBLTI_SERVERNAME:-"localhost"}

DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
groupmod -g "$DOCKER_GID" docker
usermod -aG docker cblti

[[ -n "$CBLTI_ADMIN_USER" ]] && [[ -n "$CBLTI_ADMIN_PASSWORD" ]] && echo "$CBLTI_ADMIN_PASSWORD" | htpasswd -i -c /etc/apache2/.htpasswd $CBLTI_ADMIN_USER

confd -onetime -backend env

mkdir -p /opt/processing/logs
rsync -ra /srv/www/lti/process/ /opt/processing/
chmod +x /opt/processing/process.sh

chown -R cblti:cblti /opt/processing
chown -R cblti:www-data /opt/processing/logs && chmod -R 775 /opt/processing/logs 
chown -R cblti:www-data /srv/www/lti/content && chmod -R 775 /srv/www/lti/content 

a2ensite cblti80.conf
a2ensite cblti443.conf
a2enconf cblti.conf

apache2-foreground
