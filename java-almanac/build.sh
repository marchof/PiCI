#!/bin/bash
set -e -o pipefail

. $(dirname $0)/../shared/protobuild.sh

doFetchInput() {
  fetchGitRepo "https://github.com/marchof/java-almanac.git" "master"
}

doGetInputInfo() {
  getGitInputInfo
}

doRunBuild() {
  docker build -t javaalmanacbuild ./docker/ &&
  docker run -t -i -v ${WORKSPACE_DIR}/site:/site \
                   -v ${ARTIFACTS_DIR}:/artifacts \
                   -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
                   -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
                   javaalmanacbuild
}

run "@$"
