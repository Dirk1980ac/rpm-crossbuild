#!/bin/bash

podman run \
	--rm \
	-it \
	--security-opt label=type:unconfined_t \
	--pull=never \
	-v ./input:/input \
	-v ./output:/output \
	build:test
