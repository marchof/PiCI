#!/bin/bash
set -e -o pipefail

BUILDS="jdk11u jdk12u jdk13u jdk14 jdk jdk11u-jacoco jdk12u-jacoco jdk13u-jacoco jdk14-jacoco jdk-jacoco java-almanac"

for build in $BUILDS; do
  (cd $build && ./build.sh)
done
