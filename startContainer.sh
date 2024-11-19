#!/bin/bash
./stopContainer.sh
docker container create \
	--name testing \
	-p 16010:16010 \
	-p 9868:9868 \
	-p 9870:9870 \
	db2
docker container start testing
docker container exec testing hostname -I
