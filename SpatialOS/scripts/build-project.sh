#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")"

source ./utils.sh


./download_dependencies.sh

./generate-schema-descriptor.sh

# For each worker:
for WORKER in "${WORKER_DIRS[@]}"; do
  pushd "${BUILD_DIR}/${WORKER}"
  # Compile UserCode + GeneratedC# + CoreSDK + C#SDK into a binary
  ./build.sh
  popd
done

echo "Build complete"
