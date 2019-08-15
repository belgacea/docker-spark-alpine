#!/bin/bash

set -e
source ./tag.sh

build() {
    NAME=$1
    IMAGE=belgacea/alpine-spark:${TAG}-${NAME}
    cd $([[ -z "$2" ]] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building ${IMAGE} in $(pwd)
    docker build -t ${IMAGE} .
    cd -
}

build base
build master
build worker
build sbt
build submit
#build java-template template/java
#build python-template template/scala
#build python-template template/python