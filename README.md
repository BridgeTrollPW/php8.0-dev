# php8.0-dev
Testing with php, docker container und gradle buildtools

## Docker Container
Choose any Ubuntu image and the suggested php version for it will be installed.
* Ubuntu 18.04 -> php 7.2
* Ubuntu 20.04 -> php 7.4
* Ubuntu 21.04 -> php 7.4
* Ubuntu 21.10 -> php 8.0

## Get this image
### Build the container when cloned
Run within the terminal(bash on linux / WSL2 on Windows):  
`docker build -t php8.0-dev:latest .`

### Use in your existing php project
Run `docker build https://github.com/BridgeTrollPW/php8.0-dev.git`

## Use this image
### Run container with login
This command will run the container and opens a login shell for the rootuser. Also the port 8080 will be available on the hostsystem explicitly.  
`docker run -it -p 127.0.0.1:8080:8080 php8.0-dev`

## Within the container ...
### Install dependencies
`composer install`
### Starting a local http dev server
Now, within the container, you might do anything you want, for example start a php server that is exposed to the hostsystem:  
`php -S 0.0.0.0:8080`  
The `0.0.0.0` net interface is important to not restrict access th the local host only, which would be only within the docker container.

## Gradle
>**Currently WIP**

Gradle will do the following tasks in a simplified cli form, which will be mostly the same for all projects
* install dependencies for composer and/or npm
* run tests
* run local environment
* package into folder and/or zip file
* doing all the above with docker support