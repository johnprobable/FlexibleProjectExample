#!/usr/bin/env bash

set -e -x

pushd "../SpatialOS/scripts"
source ./utils.sh
popd

# Generate C# code from the schemas:
OUT_DIR="src/improbable/generated"
mkdir -p "${OUT_DIR}"
"${TOOLS_DIR}"/schema_compiler/schema_compiler \
  --schema_path="${SCHEMA_DIR}" \
  --csharp_out="${OUT_DIR}" \
  --load_all_schema_on_schema_path \
  "${SCHEMA_DIR}"/*.schema \
  "${SCHEMA_DIR}"/improbable/*.schema

BUILD_PLATFORMS=(macOS64 Windows64 Linux64)

for PLATFORM in "${BUILD_PLATFORMS[@]}"; do
  ${BUILD_TOOL} ./src/CsharpWorker.sln /property:Configuration=Release /property:Platform="$PLATFORM"
  cp -r ./src/bin .
  rm -rf ./src/bin
  rm -rf ./src/obj
done