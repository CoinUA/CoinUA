#!/usr/bin/env bash
set -e

#update flag: -e UPDATE_BUILD=yes

BUILD_DIR=/home/vinni/Projects/CoinUA/build_docker
CONTAINER_NAME=coinua-builder
BUILD_HOST=x86_64-w64-mingw32

mkdir -p ${BUILD_DIR}

docker build --build-arg UID="$(id -u)" --build-arg GID="$(id -g)" --build-arg UNAME="$(whoami)" -t ${CONTAINER_NAME} .
docker run -i --user $(id -u):$(id -g) -v ${BUILD_DIR}:/data -e BUILD_HOST="${BUILD_HOST}" -e BUILD_WORKERS=6 -e DATA_DIR=/data -e DEBUG_FLAGS=yes -e GIT_BRANCH=update_1 ${CONTAINER_NAME}

cd "${BUILD_DIR}"/build/"${BUILD_HOST}"
zip -r ../"${BUILD_HOST}".zip .