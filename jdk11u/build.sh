#!/bin/bash

REPO_URL="https://github.com/openjdk/jdk11u.git"

git -C workspace pull || git clone ${REPO_URL} workspace

docker build -t jdkbuild ./docker/
docker run -t -i -v $(realpath ./workspace):/workspace jdkbuild
