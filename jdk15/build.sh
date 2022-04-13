#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/openjdk/jdk15u.git" "master"
}

doGetInputInfo() {
  getGitInputInfo
}

doRunBuild() {
  docker build -t jdk15build ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk15build
}

run "@$"
