#!/bin/bash

BUILDS="jdk12 jdk13 jdk"

for build in $BUILDS; do
  (cd $build && ./build.sh)
done
