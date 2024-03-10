#!/bin/bash

# NOTE: should be in GITHUB_WORKSPACE by default
source "${ZEPHYR_BUILD_ENV_SCRIPT}" || { echo "Failed to execute '${ZEPHYR_BUILD_ENV_SCRIPT}' script"; exit 1; } 

if [ $# -lt 2 ]; then
    echo "To little arguments passed to the script."
    echo "usage: ${0} BUILD_COMMAND BUILD_DIR BOARD"
    echo ""
    echo "BUILD_COMMAND: 'build' or 'test'."
    echo "BUILD_DIR: Directory of the soruce code to run the build in."
    echo "BOARD: Zephyr supported board."
    exit 1
fi

ZBEA_EP_BUILD_COMMAND="${1}"
ZBEA_EP_BUILD_DIR="${2}"
ZBEA_EP_BOARD="${3}"

case "${ZBEA_EP_BUILD_COMMAND}" in
    build)
        west build -p always -b "${ZBEA_EP_BOARD}" "${ZBEA_EP_BUILD_DIR}" || exit 1
        ;;
    test)
        west build -p always -b "${ZBEA_EP_BOARD}" "${ZBEA_EP_BUILD_DIR}" -- -DBUILD_TESTING=yes || exit 1
        ctest --test-dir build || exit 1
        ;;
    *)
        echo "Failed to handle '${ZBEA_EP_BUILD_COMMAND}' command."
        exit 1
        ;;
esac

exit 0
