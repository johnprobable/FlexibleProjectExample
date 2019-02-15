#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")"
source ./utils.sh

mkdir -p "${TOOLS_DIR}"

retrievePackage() {
  TYPE=$1
  PACKAGE=$2
  TARGETDIR=$3
  if [ ! -d "${TARGETDIR}" ]; then
    spatial package get --force --unzip "${TYPE}" "${PACKAGE}" "${SDK_VERSION}" "${TARGETDIR}"
  fi
}

# Get the tools:
# * Spatial Schema compiler
# * Standard Library Schemas
# * C# SDK
# * Core SDK for all platforms to enable building workers for MacOS, Windows or Linux
pushd "${TOOLS_DIR}"
retrievePackage "tools" "schema_compiler-x86_64-${PLATFORM_NAME}" "schema_compiler"
retrievePackage "worker_sdk" "csharp" "lib/improbable/sdk/${SDK_VERSION}/csharp"
retrievePackage "worker_sdk" "core-dynamic-x86_64-win32" "lib/improbable/sdk/${SDK_VERSION}/win64"
retrievePackage "worker_sdk" "core-dynamic-x86_64-linux" "lib/improbable/sdk/${SDK_VERSION}/linux64"
retrievePackage "worker_sdk" "core-dynamic-x86_64-macos" "lib/improbable/sdk/${SDK_VERSION}/macos64"
popd
pushd "${SCHEMA_DIR}"
retrievePackage "schema" "standard_library" ""
popd

# For each worker:
for WORKER in "${WORKER_DIRS[@]}"; do
  cp -r "${TOOLS_DIR}/lib" "${WORKER}"
done

rm -rf "${TOOLS_DIR}/lib"
