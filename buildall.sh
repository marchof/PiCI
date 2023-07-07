#!/bin/bash
set -e -o pipefail

BUILDS="jdk11 jdk12 jdk13 jdk14 jdk15 jdk16 jdk17 jdk18 jdk19 jdk20 jdk21 jdk jdk11-jacoco jdk12-jacoco jdk13-jacoco jdk14-jacoco jdk15-jacoco jdk16-jacoco jdk17-jacoco jdk18-jacoco jdk19-jacoco jdk20-jacoco jdk21-jacoco jdk-jacoco"

for build in $BUILDS; do
  (cd $build && ./build.sh)
done
