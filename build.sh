#!/bin/bash
OLDVERSION=$(cat VERSION)
VERSION=$((${OLDVERSION} + 1))
BUILD_DATE=$(date)
echo ${VERSION} > VERSION
docker build --build-arg VERSION="$VERSION" --build-arg BUILD_DATE="$BUILD_DATE" --no-cache --pull -t cullorblind/smokeping-slave:latest -t cullorblind/smokeping-slave:${VERSION} .
