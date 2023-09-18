#!/bin/sh

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $HOME/.dotfiles/Brewfile



git config --global push.default current
echo "memory_limit=-1" >> /Users/$USER/Library/Application\ Support/Herd/config/php/82/php.ini

open --background -a Docker
open --background -a Proxyman
