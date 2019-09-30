#!/bin/bash
set -e -o pipefail

docker build -t frontend ./frontend/
docker run -t -i -p 80:80 -v $(realpath .):/builds frontend
