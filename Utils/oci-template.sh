#!/usr/bin/env bash
set -e
src_path=$1
dist_path=$2
cp -f "$src_path" "$dist_path"
sed -i \
  -e "s|\${OCI_REGISTRY}|${OCI_REGISTRY}|g"  \
  -e "s|\$OCI_REGISTRY|${OCI_REGISTRY}|g"  \
  -e "s|\${OCI_REGISTRY_PATH}|${OCI_REGISTRY_PATH}|g"  \
  -e "s|\$OCI_REGISTRY_PATH|${OCI_REGISTRY_PATH}|g"  "$dist_path"