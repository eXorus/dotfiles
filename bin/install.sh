#!/bin/sh

echo $VAR1

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

if ask "When it's done I'm going to clone the dotfile repo to prepare the setup"; then
    git clone git@github.com:eXorus/dotfiles.git $HOME/.dotfiles
fi

if ask "Do you want to install homebrew?"; then
    $HOME/.dotfiles/bin/install_homebrew.sh
    
    if ask "Do you want to install all the tools and apps defined in Brewfile (please check them before)?"; then
      $HOME/.dotfiles/bin/install_apps.sh
    fi
fi

if ask "Do you want to install oh my ssh?"; then
    $HOME/.dotfiles/bin/install_omz.sh
fi

if ask "Do you want to clone the repositories?"; then
    $HOME/.dotfiles/bin/clone_repositories.sh
fi

if ask "Do you want to configure ZSH (aliases, paths,)"; then
    $HOME/.dotfiles/bin/configure_zsh.sh
fi


source $HOME/.dotfiles/.macos

