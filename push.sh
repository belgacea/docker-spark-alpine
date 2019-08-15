#!/bin/bash

set -e
source ./tag.sh

push() {
    NAME=$1
    IMAGE=belgacea/alpine-spark:${TAG}-${NAME}
    cd $([[ -z "$2" ]] && echo "./$NAME" || echo "$2")
    echo '--------------------------' pushing ${IMAGE} in $(pwd)
    docker push ${IMAGE}
    cd -
}

push base
push master
push worker
push sbt
push submit