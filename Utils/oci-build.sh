#!/usr/bin/env bash
set -e
test "$OCI_CMD" || exit 1
test "$OCI_SRC" || exit 1
test "$OCI_SRC_PATH" || exit 1
test "$OCI_SAVE_PATH" || exit 1
test "$OCI_SRC_TAG" || exit 1
test "$OCI_REGISTRY" || exit 1
test "$OCI_REGISTRY_PATH" || exit 1

SRC=$1
SRC_PATH=$2
dist=$3
test ["$OCI_CMD"]["$SRC"] || exit 1
