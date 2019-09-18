#!/bin/bash

REPO_URL="https://github.com/openjdk/jdk13.git"

git -C workspace pull || git clone ${REPO_URL} workspace

docker build -t jdk13build ./docker/
docker run -t -i -v $(realpath ./workspace):/workspace jdk13build
