IMAGE ?= docker.io/openshift/origin-docker-builder:latest
PROG  := openshift-builder
TAGS := containers_image_docker_daemon_stub containers_image_openpgp containers_image_ostree_stub exclude_graphdriver_btrfs exclude_graphdriver_devicemapper exclude_graphdriver_zfs

.PHONY: all build clean test build-image build-devel-image

all: build build-image

build:
	go build -o $(PROG) -tags "$(TAGS)" "./cmd"

build-image:
	docker build -t "$(IMAGE)" .

build-devel-image: build
	docker build -t "$(IMAGE)" -f Dockerfile-dev .

test:
	go test -tags "$(TAGS)" ./...

clean:
	rm -- "$(PROG)"
