#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/openjdk/jdk11u.git"
}

doGetInputInfo() {
  getGitInputInfo
}

doRunBuild() {
  docker build -t jdk11build ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v ${ARTIFACTS_DIR}:/artifacts jdk11build
}

run "@$"
