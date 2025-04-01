#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/openjdk/jdk.git" "jdk24"
}

doGetInputInfo() {
  getGitInputInfo
}

doRunBuild() {
  docker build -t jdkbuild ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v $(realpath ../jdk23/output/lastSuccessful/artifacts/jdk):/jdk \
                   -v ${ARTIFACTS_DIR}:/artifacts jdkbuild
}

run "@$"
