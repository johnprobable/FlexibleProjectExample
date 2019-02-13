#!/usr/bin/env bash

SDK_VERSION="13.5.1"

WORKER_DIRS=(HelloWorker DiceWorker client)
BUILD_DIR="$(pwd)/../.."
TOOLS_DIR="${BUILD_DIR}/SpatialOS/tools/${SDK_VERSION}"
SCHEMA_DIR="${BUILD_DIR}"/SpatialOS/schema

function isLinux() {
  [[ "$(uname -s)" == "Linux" ]]
}

function isMacOS() {
  [[ "$(uname -s)" == "Darwin" ]]
}

function isWindows() {
  ! (isLinux || isMacOS)
}

# Return the target platform used by worker package names built for this OS.
function getPlatformName() {
  if isLinux; then
    echo "linux"
  elif isMacOS; then
    echo "macos"
  elif isWindows; then
    echo "win32"
  else
    echo "ERROR: Unknown platform." >&2
    exit 1
  fi
}

PLATFORM_NAME=$(getPlatformName)

BUILD_TOOL="msbuild"
if isWindows; then
  BUILD_TOOL="MSBuild.exe"
fi