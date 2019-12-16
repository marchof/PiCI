#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchHgRepo "http://hg.openjdk.java.net/jdk/jdk/" "default"
}

doGetInputInfo() {
  getHgInputInfo
}

doRunBuild() {
  docker build -t jdkbuild ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v ${ARTIFACTS_DIR}:/artifacts jdkbuild
}

run "@$"
