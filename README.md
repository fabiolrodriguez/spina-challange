# spina-challange

This repo is organized in 2 layers

```
├── application    
└── infrastructure
 ```

 * Application folder keeps the Dockerfiles relative to the app
 * Infrastructure folder keeps the terraform files to create the AWS ECS environment

## Pre requisites

* AWS account
* IAM user with CMD access
* AWS cli configured on local machine: https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html
* Terraform 1.5 or later
* Docker and docker compose installed

## Create infrastructure

Export your AWS profile:

```
export AWS_PROFILE=your-profile
```

Create infrastructure:
```
make infrastructure
```

## Build

Build the image
```
make build
```

## Deploy

Deploy the application
```
make deploy
```