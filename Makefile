
IMAGE_NAME = isolde-elog-centos7

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

