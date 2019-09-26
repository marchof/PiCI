#!/bin/bash
set -e

REPO_URL="https://github.com/jacoco/jacoco.git"

git -C workspace pull || git clone ${REPO_URL} workspace

REVISION=$(git -C workspace rev-parse HEAD)

ARTIFACTS="artifacts/${REVISION}"

if [ ! -d "${ARTIFACTS}" ]; then

  mkdir -p "${ARTIFACTS}"
  ln -sf "${REVISION}" artifacts/latest

  docker build -t jacocobuild ./docker/
  docker run -t -i -v $(realpath ./workspace):/workspace -v $(realpath ../jdk/artifacts/lastSuccessful/jdk):/jdk -v m2repo:/m2repo -v $(realpath ${ARTIFACTS}):/artifacts jacocobuild

  ln -sf "${REVISION}" artifacts/lastSuccessful

fi
