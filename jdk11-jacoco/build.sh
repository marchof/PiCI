#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/jacoco/jacoco.git" "master"
}

doGetInputInfo() {
  getGitInputInfo
  cat ../jdk11/output/lastSuccessful/INPUT || true
}

doRunBuild() {
  docker build -t jdk11jacocobuild ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v $(realpath ../jdk11/output/lastSuccessful/artifacts/jdk):/jdk \
                   -v m2repo:/m2repo \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk11jacocobuild
}

run "@$"
