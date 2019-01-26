#!/usr/bin/env bash

# Read current dir of shell script
SCRIPT=$(readlink -f "$0")
BASE_DIR=$(dirname "$SCRIPT")

TEST_TIMEZONE="UTC"

# Dynamically get absolute base dir
EZ_PLATFORM_BUILD_DIR=${BASE_DIR}/../build/ezsystems/ezplatform
EZ_PLATFORM_VERSION=1.7

# Go to ezplatform
cd ${EZ_PLATFORM_BUILD_DIR}

# Start docker
COMPOSE_FILE="${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml:${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml" \
 docker-compose up -d

# Run tests
COMPOSE_FILE="${EZ_PLATFORM_BUILD_DIR}/doc/docker/base-dev.yml:${EZ_PLATFORM_BUILD_DIR}/doc/docker/selenium.yml" \
 docker-compose exec --user www-data app app/console ezplatform:install clean && \
 docker-compose exec --user www-data app sh -c "php -d date.timezone=${TEST_TIMEZONE} -d memory_limit=-1 bin/phpunit -v vendor/ezsystems/ezpublish-kernel/eZ/Bundle/EzPublishRestBundle/Tests/Functional"