TOP_DIR := $(shell pwd)
setup:
	@make -C terraform init TOP_DIR=$(TOP_DIR)
	@make -C ansible init TOP_DIR=$(TOP_DIR)

deploy:
	@make -C ansilbe deploy TOP_DIR=$(TOP_DIR)

destroy:
	@make -C terraform destroy TOP_DIR=$(TOP_DIR)
