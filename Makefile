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
	echo "building the application"

deploy: # Deploy the application

destroy: # Destroy infrastructure
	terraform -chdir=$(WORKDIR) destroy
