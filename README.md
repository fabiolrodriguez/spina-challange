# spina-challange

This repo is organized in 2 layers

```
├── app    
└── infrastructure
 ```

 * app folder keeps the Dockerfiles relative to the app
 * Infrastructure folder keeps the terraform files to create the AWS ECS environment

 ## Overview

 The chosen services to run this apps are:

 * AWS as a cloud provider
 * ECS  to host the application
 * ECR to keep the images
 * RDS to serve the postgres database
 * Cloudwatch for logs
 * ECS cluster and database running on Multi-AZ deployment
 * Terraform used to code infrastructure
 * Makefile used to simplify the tasks

## Pre requisites

* AWS account
* IAM user with CMD access
* AWS cli configured on local machine: https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html
* Terraform 1.5 or later
* Docker and docker compose installed

## Running local

Go to the application dir

```
cd app
```

Build the image

```
docker-compose build web
```

Bring database and application up

```
docker-compose up -d
```

Create the database

```
docker-compose run web rails db:create
docker-compose run web rails db:migrate 
```

Install Spina CMS

```
docker-compose run web rails g spina:install
```

## Building production image

```
docker-compose build web-prod
```

## References

* https://github.com/utibeabasi6/docker-rails
* https://github.com/SpinaCMS/Spina
* https://github.com/SpinaCMS/SpinaCMS-Demo
* https://guides.rubyonrails.org/configuring.html
* https://earthly.dev/blog/rails-with-docker/
* https://github.com/jigarius/docker-rails-example/
* https://github.com/fabiolrodriguez/terraform-challange

## To-do

- [x] Set Spina CMS run properly, for now it is just a vanilla rails running
- [ ] Fix the runtime error on production image
- [ ] Improve the docker image with best pratices for ruby applications
- [ ] Improve security
- [ ] Setup HTTPS
- [ ] Setup a CI/CD pipeline

## Notes

This is my very first contact with a ruby application, so there are mistakes and errors here for now.

## Changelog

* Fixed local spina image and installation
* Added named volume to docker-compose file to persist ruby files and local db
* Fixed Dockerfile
* Create separated dockerfiles for prod and dev
* docker-compose now can build image for development and production