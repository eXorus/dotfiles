#!/bin/sh

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $HOME/.dotfiles/Brewfile



git config --global push.default current
echo "memory_limit=-1" >> /Users/$USER/Library/Application\ Support/Herd/config/php/82/php.ini

open --background -a Docker
open --background -a Proxyman


xattr -d com.apple.quarantine /Applications/Spotify.app
xattr -d com.apple.quarantine /Applications/Docker.app
xattr -d com.apple.quarantine /Applications/Postman.app
xattr -d com.apple.quarantine /Applications/Herd.app
xattr -d com.apple.quarantine /Applications/Proxyman.app
xattr -d com.apple.quarantine /Applications/TablePlus.app
xattr -d com.apple.quarantine /Applications/Visual\ Studio\ Code.app
xattr -d com.apple.quarantine /Applications/Sublime\ Text.app
xattr -d com.apple.quarantine /Applications/PhpStorm.app
