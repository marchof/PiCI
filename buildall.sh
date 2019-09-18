#!/bin/bash

BUILDS="jdk12u jdk13 jdk"

for build in $BUILDS; do
  (cd $build && ./build.sh)
done
