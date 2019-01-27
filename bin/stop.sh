#!/usr/bin/env bash

# Read current dir of shell script
SCRIPT=$(readlink -f "$0")
BASE_DIR=$(dirname "$SCRIPT")

# Remove old setups fist
/bin/bash ${BASE_DIR}/clean.sh