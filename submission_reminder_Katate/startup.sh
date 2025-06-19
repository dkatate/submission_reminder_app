#!/usr/bin/env bash
# Source configuration and functions
cd "$(dirname "$0")" || exit 1
source ./config/config.env
source ./modules/functions.sh
# Change into the script's own directory

./app/reminder.sh
