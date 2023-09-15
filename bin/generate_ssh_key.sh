#!/bin/sh

echo "Generating a new SSH key for GitHub..."


echo "You don't need to set a passphrase, but if you set it then do this to add it in your keychain automatically. https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"

# Generating a new SSH key
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519

# Adding your SSH key to your GitHub account
# https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
echo "Your SSH Key has been generated, here is the public key:"
cat ~/.ssh/id_ed25519.pub

echo "Public SSH Key copied, paste that into GitHub"
pbcopy < ~/.ssh/id_ed25519.pub


echo 'Go to https://github.com/settings/keys and upload your new SSH key and clean the old one if needed

- Update your personal GitHub account settings to **enable Double Authentification** https://github.com/settings/security
- Update your **GitHub account password** if you think it is not already secured enough

- Add your **public ssh key** on https://github.com/settings/keys

'
