#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/jacoco/jacoco.git"
}

doGetInputInfo() {
  getGitInputInfo
  cat ../jdk/output/lastSuccessful/INPUT || true
}

doRunBuild() {
  docker build -t jacocobuild ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}:/workspace \
                   -v $(realpath ../jdk/output/lastSuccessful/artifacts/jdk):/jdk \
                   -v m2repo:/m2repo \
                   -v ${ARTIFACTS_DIR}:/artifacts jacocobuild
}

run "@$"
