#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/AdoptOpenJDK/openjdk-jdk13u.git" "master"
}

doGetInputInfo() {
  getGitInputInfo
}

doRunBuild() {
  docker build -t jdk13build ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk13build
}

run "@$"
