#!/bin/bash

hg pull   --repository workspace
hg update --repository workspace
hg heads  --repository workspace

docker build -t jdkbuild ./docker/
docker run -t -i -v $(realpath ./workspace):/workspace jdkbuild
