#!/bin/bash

hg pull   --repository workspace
hg update --repository workspace
hg heads  --repository workspace

docker build -t jdk12build ./docker/
docker run -t -i -v $(realpath ./workspace):/workspace jdk12build
