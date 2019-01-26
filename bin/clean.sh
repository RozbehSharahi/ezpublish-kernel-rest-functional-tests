#!/usr/bin/env bash

# Read current dir of shell script
SCRIPT=$(readlink -f "$0")
BASE_DIR=$(dirname "$SCRIPT")

TEST_TIMEZONE="UTC"

# Dynamically get absolute base dir
EZ_PLATFORM_BUILD_DIR=${BASE_DIR}/../build/ezsystems/ezplatform
EZ_PLATFORM_VERSION=1.7

# Clean docker
COMPOSE_FILE="${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml:${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml" \
 docker-compose down --remove-orphans

# Go to ezplatform
sudo rm -rf ${EZ_PLATFORM_BUILD_DIR}