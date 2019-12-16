#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchHgRepo "http://hg.openjdk.java.net/jdk-updates/jdk11u/" "default"
}

doGetInputInfo() {
  getHgInputInfo
}

doRunBuild() {
  docker build -t jdk11build ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk11build
}

run "@$"
