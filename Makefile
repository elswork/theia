SNAME ?= theia
NAME ?= elswork/$(SNAME)
VER ?= `cat VERSION`
BASE ?= latest
BASENAME ?= node:12.18.3-alpine

# HELP
# This will output the help for each task

.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build image

debug: ## Debug the container
	docker build -t $(RNAME):debug \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .
build: ## Build the container
	mkdir -p builds
	docker build --no-cache -t $(RNAME):$(VER) \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) \
	. > builds/$(VER)_`date +"%Y%m%d_%H%M%S"`.txt
	bootstrap: ## Start multicompiler
	docker buildx inspect --bootstrap
debugx: ## Buildx in Debug mode
	docker buildx build \
	-t $(RNAME):debug --pull --load \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .
buildx: ## Buildx the container
	docker buildx build --no-cache \
	--platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6 \
  	-t $(RNAME):latest -t $(RNAME):$(VER) --pull --push \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .

# Operations

console: ## Start console in container
	docker run -it --rm --entrypoint "/bin/ash" $(RNAME):$(VER)
debugconsole: ## Start a debug console in container
	docker run -it --rm --entrypoint "/bin/ash" $(RNAME):debug
start: ## Start Theia IDE
	docker run -d -p 3000:3000 -v "$(pwd):/home/project:cached" $(NAME)
