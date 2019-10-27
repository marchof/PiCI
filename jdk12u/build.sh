#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/openjdk/jdk12u.git" "master"
}

doGetInputInfo() {
  getGitInputInfo
}

doRunBuild() {
  docker build -t jdk12build ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk12build
}

run "@$"
