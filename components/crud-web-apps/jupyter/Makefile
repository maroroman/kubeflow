GIT_TAG ?= $(shell git describe --tags --always)
IMG ?= quay.io/mroman_redhat/jh-web-app
DOCKERFILE ?= jupyter/Dockerfile

podman-build:
	cd ../ && podman build -t ${IMG}:${GIT_TAG} -f ${DOCKERFILE} .

podman-push:
	podman push $(IMG):$(GIT_TAG)

image: podman-build podman-push
