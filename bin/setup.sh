#!/usr/bin/env bash

# Read current dir of shell script
SCRIPT=$(readlink -f "$0")
BASE_DIR=$(dirname "$SCRIPT")

# Dynamically get absolute base dir
EZ_PLATFORM_BUILD_DIR=${BASE_DIR}/../build/ezsystems/ezplatform

# Get the working dir
PROJECT_DIR=${BASE_DIR}/../../

# Which version
echo "Which version/branch of ez Platform do you want to install? (f.i.: master or 1.7)"
read EZ_PLATFORM_VERSION

# Remove old setups fist
/bin/bash ${BASE_DIR}/clean.sh

# Create dir
mkdir -p ${EZ_PLATFORM_BUILD_DIR}

# Go into dir
cd ${EZ_PLATFORM_BUILD_DIR}

# Clone ez platform
git clone https://github.com/ezsystems/ezplatform.git .

# Checkout compatible version
git checkout ${EZ_PLATFORM_VERSION}

cp ${BASE_DIR}/../tools/add-kernel-path-to-composer.php ${EZ_PLATFORM_BUILD_DIR}

# Start docker
docker-compose \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml \
 -f ${BASE_DIR}/../docker/base-dev.extend.yml \
 up -d

# Modify composer.json to use mounted working kernel
docker-compose \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml \
 -f ${BASE_DIR}/../docker/base-dev.extend.yml \
 exec app sh -c "php add-kernel-path-to-composer.php"