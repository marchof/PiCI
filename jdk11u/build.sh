#!/bin/bash
set -e

REPO_URL="https://github.com/openjdk/jdk11u.git"

git -C workspace pull || git clone ${REPO_URL} workspace

REVISION=$(git -C workspace rev-parse HEAD)

ARTIFACTS="artifacts/${REVISION}"

if [ ! -d "${ARTIFACTS}" ]; then

  mkdir -p "${ARTIFACTS}"
  ln -sfn "${REVISION}" artifacts/latest

  docker build -t jdk11build ./docker/ | tee ${ARTIFACTS}/docker-build.log
  docker run -t -i -v $(realpath ./workspace):/workspace \
                   -v $(realpath ${ARTIFACTS}):/artifacts jdk11build | tee ${ARTIFACTS}/build.log

  ln -sfn "${REVISION}" artifacts/lastSuccessful

fi

