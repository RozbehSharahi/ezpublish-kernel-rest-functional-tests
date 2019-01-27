#!/usr/bin/env bash

# Read current dir of shell script
SCRIPT=$(readlink -f "$0")
BASE_DIR=$(dirname "$SCRIPT")

# Dynamically get absolute base dir
EZ_PLATFORM_BUILD_DIR=${BASE_DIR}/../build/ezsystems/ezplatform

# Start docker
docker-compose \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml \
 -f ${BASE_DIR}/../docker/base-dev.extend.yml \
 exec app bash