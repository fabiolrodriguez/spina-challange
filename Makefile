SHELL=/bin/bash

.PHONY: help infrastructure build deploy destroy

WORKDIR=./infrastructure

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

plan:
	terraform -chdir=$(WORKDIR) plan	

infrastructure: # Create infrastructure
	terraform -chdir=$(WORKDIR) init
	terraform -chdir=$(WORKDIR) apply --auto-approve

build: # Build the application	
	cd app && docker build --target production --platform linux/amd64 . -t spina:latest

deploy: # Deploy the application
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 818179646404.dkr.ecr.us-east-1.amazonaws.com
	docker tag spina:latest 818179646404.dkr.ecr.us-east-1.amazonaws.com/test-spina:latest
	docker push 818179646404.dkr.ecr.us-east-1.amazonaws.com/test-spina:latest
	aws ecs update-service --service spina-service --force-new-deployment --cluster test-cluster --region=us-east-1 --no-cli-pager

destroy: # Destroy infrastructure
	terraform -chdir=$(WORKDIR) destroy
