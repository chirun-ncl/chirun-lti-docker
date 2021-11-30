# Docker Compose Recipe for Chirun LTI Tool

This repository contains everything needed to run the Chirun LTI tool in Docker containers.

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

Stop the containers with
```
docker-compose down
```

## LTI Setup
To use the Chirun LTI tool with your VLE, an administrator will need to add the tool to your own instance of the VLE. To do this, the VLE needs to be setup beforehand as a tool consumer in the admin panel accessible on your web server at https://chirun-lti.institution.tld/lti/admin/. Login with the administrator account setup in the file `settings.env`.

Create a Name, Key, and Secret for your VLE using the Add New Consumer form on the admin page, and then forward that information on to your VLE administrator to be added as an external LTI tool.

They might also need the URL for the LTI XML configuration, https://chirun-lti.institution.tld/lti/xml/ or the LTI launch URL, https://chirun-lti.institution.tld/lti/connect.php.

### Landing Page
A simple landing page for the root of the webserver at https://chirun-lti.institution.tld has been included in `files/cblti/index.html`. This file is bind mounted by Docker at launch and so can be directly edited by the server administrator as required.

## Running in the cloud

Docker Compose files can also be used to deploy to the cloud. See the following documents for more information about deploying Docker to the cloud:
 - [Compose for Amazon ECS](https://docs.docker.com/engine/context/ecs-integration/)
 - [Compose for Microsoft ACI](https://docs.docker.com/engine/context/aci-integration/)

## Upgrade instructions

To upgrade to a new version, fetch the latest version of this repo and then,

```
docker-compose up --build
```
