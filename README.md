# Docker Compose Recipe for NCL CourseBuilder LTI Tool

This repository contains everything needed to run the NCL CourseBuilder LTI tool in Docker containers.

## Documentation

There's documentation for administrators, instructors and students at TBD.

## Installation

### Prerequisites

Install [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) on your server.

### Setup

Clone this repo somewhere on your server and `cd` into the directory.

Copy the file `settings.env.dist` to `settings.env` and write your own values each of the variables inside.

Obtain an SSL certificate and key for the domain you will access the CB LTI tool from.
Copy the key to `files/ssl/cblti.key` and the certificate to `files/ssl/cblti.pem`.

### Starting

Run the following command in the directory where `docker-compose.yml` resides:

```
docker-compose up
```

### Stopping

Stop the containers with `docker-compose down`.

## Running in the cloud

Docker Compose files can also be used to deploy to the cloud. See the following documents for more information about deploying Docker to the cloud:
 - [Compose for Amazon ECS](https://docs.docker.com/engine/context/ecs-integration/)
 - [Compose for Microsoft ACI](https://docs.docker.com/engine/context/aci-integration/)

### Standard upgrade instructions

To upgrade to a new version, fetch the latest version of this repo and then,

```
docker-compose up --build
```
