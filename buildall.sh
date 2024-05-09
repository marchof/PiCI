#!/bin/bash
set -e -o pipefail

BUILDS="jdk11 jdk17 jdk18 jdk19 jdk20 jdk21 jdk22 jdk jdk11-jacoco jdk17-jacoco jdk18-jacoco jdk19-jacoco jdk20-jacoco jdk21-jacoco jdk-jacoco"

for build in $BUILDS; do
  (cd $build && ./build.sh)
done
