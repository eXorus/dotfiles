#!/bin/sh

ring_bell() {
  # Use the shell's audible bell.
  if [[ -t 1 ]]
  then
    printf "\a"
  fi
}

ask() {
    ring_bell
    read -p "$1 [Yes/No]: " response
    case "$response" in
        [yY]|[yY][eE][sS]) return 0 ;;
        *) return 1 ;;
    esac
}

if ask "Should I generate a new SSH Key for GitHub?"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/exorus/dotfiles/HEAD/bin/generate_ssh_key.sh)"
fi
