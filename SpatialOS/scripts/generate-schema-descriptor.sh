#!/usr/bin/env bash

set -e -x
source ./utils.sh
pushd "../"

SCHEMA_BIN_DIR="${BUILD_DIR}"/SpatialOS/schema_out/bin

# Generate a schema descriptor from the schemas:
"${TOOLS_DIR}"/schema_compiler/schema_compiler \
  --schema_path="${SCHEMA_DIR}" \
  --schema_path="${TOOLS_DIR}"/standard_library \
  --descriptor_set_out="${SCHEMA_BIN_DIR}"/schema.descriptor \
  --load_all_schema_on_schema_path \
  "${SCHEMA_DIR}"/*.schema \
  "${TOOLS_DIR}"/standard_library/improbable/*.schema

popd