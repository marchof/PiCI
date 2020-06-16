#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/jacoco/jacoco.git" "master"
}

doGetInputInfo() {
  getGitInputInfo
  cat ../jdk15/output/lastSuccessful/INPUT || true
}

doRunBuild() {
  docker build -t jdk15jacocobuild ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v $(realpath ../jdk15/output/lastSuccessful/artifacts/jdk):/jdk \
                   -v m2repo:/m2repo \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk15jacocobuild
}

run "@$"
