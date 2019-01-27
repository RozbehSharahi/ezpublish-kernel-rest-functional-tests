#!/usr/bin/env bash

# Read current dir of shell script
SCRIPT=$(readlink -f "$0")
BASE_DIR=$(dirname "$SCRIPT")

# Dynamically get absolute base dir
EZ_PLATFORM_BUILD_DIR=${BASE_DIR}/../build/ezsystems/ezplatform

# Go to ezplatform
sudo chmod -R 777 ${EZ_PLATFORM_BUILD_DIR}
cd ${EZ_PLATFORM_BUILD_DIR}

# Start docker
docker-compose \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml \
 -f ${BASE_DIR}/../docker/base-dev.extend.yml \
 up -d

# install
docker-compose \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml \
 -f ${BASE_DIR}/../docker/base-dev.extend.yml \
 exec app sh -c "composer install && app/console ezplatform:install clean"

# run tests
docker-compose \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml \
 -f ${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml \
 -f ${BASE_DIR}/../docker/base-dev.extend.yml \
 exec app \
 sh -c "php -d memory_limit=-1 bin/phpunit vendor/ezsystems/ezpublish-kernel/eZ/Bundle/EzPublishRestBundle/Tests/Functional"