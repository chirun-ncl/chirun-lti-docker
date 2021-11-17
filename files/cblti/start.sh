#!/bin/bash

DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
groupmod -g "$DOCKER_GID" docker
usermod -aG docker cblti

apache2-foreground
