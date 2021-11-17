ARG VERSION=0.2

FROM php:8.0-apache

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends apt-utils apt-transport-https ca-certificates curl gnupg2 software-properties-common lsb-release sudo
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update -y && apt-get -y install docker-ce

RUN useradd -ms /bin/bash cblti && usermod -a -G www-data cblti

CMD ["/bin/bash", "/cblti/start.sh"]
