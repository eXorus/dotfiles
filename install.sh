#!/bin/bash

# We don't need return codes for "$(command)", only stdout is needed.
# Allow `[[ -n "$(command)" ]]`, `func "$(command)"`, pipes, etc.
# shellcheck disable=SC2312

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

# string formatters
if [[ -t 1 ]]
then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"


getc() {
  local save_state
  save_state="$(/bin/stty -g)"
  /bin/stty raw -echo
  IFS='' read -r -n 1 -d '' "$@"
  /bin/stty "${save_state}"
}

ring_bell() {
  # Use the shell's audible bell.
  if [[ -t 1 ]]
  then
    printf "\a"
  fi
}

wait_for_user() {
  local c
  echo
  echo "Press ${tty_bold}RETURN${tty_reset}/${tty_bold}ENTER${tty_reset} to continue or any other key to abort:"
  getc c
  # we test for \r and \n because some stuff does \r instead
  if ! [[ "${c}" == $'\r' || "${c}" == $'\n' ]]
  then
    exit 1
  fi
}

ask() {
  local c
  echo
  echo "Press ${tty_bold}RETURN${tty_reset}/${tty_bold}ENTER${tty_reset} to continue or any other key to abort: (Y/N)"
  getc c
  # we test for \r and \n because some stuff does \r instead
  if ! [[ "${c}" == $'Y' || "${c}" == $'y' ]]
  then
    exit 1
  else
    exit 0
  fi
}

# First check OS.
OS="$(uname)"
if [[ "${OS}" == "Darwin" ]]
then
  INSTALL_ON_MACOS=1
else
  abort "Install is only supported on macOS."
fi

# ##############

if ask "Do you want to install a new ssh key?"
then
  abort "yes I want"
else
  abort "no I don't"
fi


# ##############

ring_bell
wait_for_user

local c
echo
echo "Press ${tty_bold}1${tty_reset}/${tty_bold}2${tty_reset} to continue or any other key to abort:"
getc c
# we test for \r and \n because some stuff does \r instead
if [[ "${c}" == $'1' || "${c}" == $'2' ]]
then
  abort "1 and 2 pressed."
else
  abort "not pressed"
fi

//generate SSH Key
//wait for key copied in github
//clone dotfiles repository with git
//start fresh
