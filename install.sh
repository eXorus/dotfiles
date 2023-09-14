#!/bin/bash

# We don't need return codes for "$(command)", only stdout is needed.
# Allow `[[ -n "$(command)" ]]`, `func "$(command)"`, pipes, etc.
# shellcheck disable=SC2312

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

# First check OS.
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
  abort "Homebrew is supported on linux."
elif [[ "${OS}" == "Darwin" ]]
then
  abort "Homebrew is supported on macOS."
else
  abort "Homebrew is only supported on macOS and Linux."
fi
