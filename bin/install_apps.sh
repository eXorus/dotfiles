#!/bin/sh

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $HOME/.dotfiles/Brewfile



echo "memory_limit=-1" >> /Users/$USER/Library/Application\ Support/Herd/config/php/82/php.ini
