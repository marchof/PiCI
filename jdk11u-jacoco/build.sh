#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/jacoco/jacoco.git"
}

doGetInputInfo() {
  getGitInputInfo
  cat ../jdk11u/output/lastSuccessful/INPUT || true
}

doRunBuild() {
  docker build -t jdk11ujacocobuild ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v $(realpath ../jdk11u/output/lastSuccessful/artifacts/jdk):/jdk \
                   -v m2repo:/m2repo \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk11ujacocobuild
}

run "@$"
