#!/bin/sh

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


echo 'Go to https://github.com/settings/keys and upload your new SSH key and clean the old one if needed'
