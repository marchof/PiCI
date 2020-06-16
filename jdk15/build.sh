#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchHgRepo "http://hg.openjdk.java.net/jdk/jdk15/" "default"
}

doGetInputInfo() {
  getHgInputInfo
}

doRunBuild() {
  docker build -t jdk15build ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk15build
}

run "@$"
