#!/bin/bash
VERSION=$(cat VERSION)
if [ "$1" = "--new" ]; then
  VERSION=$((${VERSION} + 1))
fi
echo ${VERSION} > VERSION

docker build --build-arg VERSION="$VERSION" --build-arg BUILD_DATE="$BUILD_DATE" --no-cache --pull -t computercolin/smokeping-slave:latest -t computercolin/smokeping-slave:${VERSION} .
