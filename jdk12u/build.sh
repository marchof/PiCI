#!/bin/bash

REPO_URL="https://github.com/openjdk/jdk12u.git"

git -C workspace pull || git clone ${REPO_URL} workspace

docker build -t jdk12build ./docker/
docker run -t -i -v $(realpath ./workspace):/workspace jdk12build
