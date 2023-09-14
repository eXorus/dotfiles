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

# First check OS.
OS="$(uname)"
if [[ "${OS}" == "Darwin" ]]
then
  INSTALL_ON_MACOS=1
else
  abort "Install is only supported on macOS."
fi

# ##############

# Fonction pour poser la question
ask() {
    ring_bell
    read -p "$1 [Yes/No]: " response
    case "$response" in
        [yY]|[yY][eE][sS]) return 0 ;;
        *) return 1 ;;
    esac
}

generate_ssh_key() {
  echo "Generating a new SSH key for GitHub..."

  # Generating a new SSH key
  # https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
  
  # Adding your SSH key to your GitHub account
  # https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
  echo "Your SSH Key has been generated, here is the public key:"
  cat ~/.ssh/id_ed25519.pub
  
  echo "Public SSH Key copied, paste that into GitHub"
  pbcopy < ~/.ssh/id_ed25519.pub
  
  
  echo 'Go to https://github.com/settings/keys and upload your new SSH key and clean the old one if needded'
}

clone_dotfiles() {
  echo "Cloning dotfiles repositories..."

  git clone git@github.com:eXorus/dotfiles.git $HOME/.dotfiles2

}

if ask "Should I generate a new SSH Key?"; then
    generate_ssh_key
fi


if ask "When it's done I'm going to clone the dotfile repo, are you ready?"; then
    clone_dotfiles
fi


# ##############



//generate SSH Key
//wait for key copied in github
//clone dotfiles repository with git
//start fresh
