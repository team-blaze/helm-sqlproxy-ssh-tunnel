#!/usr/bin/make -f

REGISTRY ?= berylcc
NAME := sqlproxy-ssh-tunnel
TAG ?= 1.0.1
IMAGE := $(REGISTRY)/$(NAME):$(TAG)

ifeq ($(REGISTRY),)
$(error Must specify REGISTRY variable)
endif

all: push

push: image
	docker push $(IMAGE)

image: Dockerfile
	docker build -f Dockerfile -t $(IMAGE) .

package:
	helm package ./$(NAME)
	mv $(NAME)*.tgz docs
	helm repo index docs --url https://team-blaze.github.io/helm-sqlproxy-ssh-tunnel

.PHONY: image push package
