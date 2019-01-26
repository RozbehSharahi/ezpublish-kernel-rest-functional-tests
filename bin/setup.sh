#!/usr/bin/env bash

# Read current dir of shell script
SCRIPT=$(readlink -f "$0")
BASE_DIR=$(dirname "$SCRIPT")

# Dynamically get absolute base dir
EZ_PLATFORM_BUILD_DIR=${BASE_DIR}/../build/ezsystems/ezplatform
EZ_PLATFORM_VERSION=1.7
PROJECT_DIR=${BASE_DIR}/../../

# Create dir
mkdir -p ${EZ_PLATFORM_BUILD_DIR}

# Go into dir
cd ${EZ_PLATFORM_BUILD_DIR}

# Clone ez platform
git clone https://github.com/ezsystems/ezplatform.git .

# Checkout compatible version
git checkout ${EZ_PLATFORM_VERSION}

# Replace kernel with your current work dir
if [[ ! -L vendor/ezsystems/ezpublish-kernel/ ]]; then
    rm -rf vendor/ezsystems/ezpublish-kernel/
    ln -s ${PROJECT_DIR} vendor/ezsystems/ezpublish-kernel
fi

# Start docker
echo "Building docker, this will take a while, please wait until the container aborts."
COMPOSE_FILE="doc/docker/base-dev.yml:doc/docker/selenium.yml" \
 docker-compose -f doc/docker/install.yml up --abort-on-container-exit