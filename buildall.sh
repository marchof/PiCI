#!/bin/bash
set -e -o pipefail

BUILDS="jdk11u jdk12u jdk13 jdk jdk11u-jacoco jdk12u-jacoco jdk13-jacoco jdk-jacoco"

for build in $BUILDS; do
  (cd $build && ./build.sh)
done
