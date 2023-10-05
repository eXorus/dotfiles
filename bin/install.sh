#!/bin/sh

# Define color codes
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
GRAY='\033[90m'
RESET="\033[0m"
BULLET="${YELLOW}•${RESET}"

ring_bell() {
  # Use the shell's audible bell.
  if [[ -t 1 ]]
  then
    printf "\a"
  fi
}

ask() {
    ring_bell
    printf "$1 [Yes/No]: "
    read response
    case "$response" in
        [yY]|[yY][eE][sS]) return 0 ;;
        *) return 1 ;;
    esac
}

wait() {
    ring_bell
    echo " "
    read -n 1 -s -r -p "Please proceed when ready. Press any key to continue..."
    echo " "
}

display_section() {
    local text="$1"
    local section_number="$2"

    # Afficher la bannière avec le texte coloré et le fond de couleur
    printf "\n\n"
    printf "%s" "$(tput setab 3)"  # Définir la couleur de fond
    printf "%s%s%s\n" "$(tput setaf 0) $section_number/5 $(tput sgr0) $text"
    printf "\n"
}

ask_clone_repo() {
  ask "Should I clone ${GREEN}$1${RESET} in $2? ${GRAY}$3${RESET}"
}



echo "${GREEN}"
echo "███████╗████████╗ █████╗ ██████╗ ████████╗███████╗██████╗     ██╗  ██╗██╗████████╗"
echo "██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██╔══██╗    ██║ ██╔╝██║╚══██╔══╝"
echo "███████╗   ██║   ███████║██████╔╝   ██║   █████╗  ██████╔╝    █████╔╝ ██║   ██║   "
echo "╚════██║   ██║   ██╔══██║██╔══██╗   ██║   ██╔══╝  ██╔══██╗    ██╔═██╗ ██║   ██║   "
echo "███████║   ██║   ██║  ██║██║  ██║   ██║   ███████╗██║  ██║    ██║  ██╗██║   ██║   "
echo "╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝   ╚═╝   "
echo "${RESET}"

echo " "
echo "Welcome to the ${GREEN}Quality Engineering Starter Kit${RESET}"
echo "Get ready to supercharge your Mac setup!"
echo " "

echo "${YELLOW}This script will assist you in the following tasks:${RESET}"
echo "${BULLET} 1- Generate your SSH Key for GitHub access"
echo "${BULLET} 2- Install Homebrew, the package manager for macOS, and use it to install essential tools and apps"
echo "${BULLET} 3- Clone the necessary GitHub repositories"
echo "${BULLET} 4- Set up some useful aliases for your convenience"
echo "${BULLET} 5- Set up the apps"



# ----------------------------------------------
# SECTION 1: SSH Key
# ----------------------------------------------
display_section "SSH Key" 1

if ask "Should I generate a new SSH Key for GitHub?"; then

  echo " "
  echo "${YELLOW}You don't need to set a passphrase, but if you set it then do this to add it in your keychain automatically. https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent ${RESET}"
  echo " "

  # Generating a new SSH key
  # https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
  # ssh-keygen -t ed25519 -f ~/.ssh/test_ssh_key

  echo "${GREEN}Your SSH Key has been generated, here is the public key. It has also been copied to your clipboard for easy pasting into GitHub:${RESET}"
  cat ~/.ssh/id_ed25519.pub
  pbcopy < ~/.ssh/id_ed25519.pub

  echo " "
  echo "${RED}Actions to take:${RESET}"
  echo "- Go to https://github.com/settings/keys and paste your new SSH Public Key"
  echo "- Clean the old one if needed"
  echo "- Ensure you update your personal GitHub account settings to enable Double Authentication at https://github.com/settings/security"
  echo "- Ensure you update your personal GitHub account password if you believe it's not already secure enough."

  wait
fi

DOTFILES_DIR=$HOME/.dotfiles

echo " "
echo "${YELLOW}Cloning the dotfiles repository... ${RESET}"
git clone git@github.com:exorus/dotfiles.git $DOTFILES_DIR


# ----------------------------------------------
# SECTION 2: Apps and Tools
# ----------------------------------------------
display_section "Apps and Tools" 2

if ! command -v brew &> /dev/null; then 

  echo " "
  echo "${YELLOW}Installing brew... ${RESET}"
  echo " "
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"

else
  # Update Homebrew recipes
  echo " "
  echo "${YELLOW}Updating brew... ${RESET}"
  brew update
fi

echo " "
echo "${RED}Actions to take:${RESET}"
echo "Review the file ${DOTFILES_DIR}/Brewfile to add apps or tools that you want or remove those you don't need."

wait


if ask "Should I install the apps and tools?"; then
  # Install all our dependencies with bundle (See Brewfile)
  brew tap homebrew/bundle
  brew bundle --file $DOTFILES_DIR/Brewfile

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
fi

if ! command -v omz &> /dev/null; then
  if ask "Do you want to install Oh My SSH to make your terminal look more stylish?"; then
    echo " "
    echo "${YELLOW}Installing omz... ${RESET}"
      /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
  fi
else
  echo " "
  echo "${YELLOW}Updating omz... ${RESET}"
  omz update
fi



# ----------------------------------------------
# SECTION 3: Git Repositories
# ----------------------------------------------
display_section "Git Repositories" 3

if ask "Should I clone the most used git repositories?"; then

  git config --global user.name "$USER"
  git config --global user.email "$USER@openclassrooms.com"
  git config --global push.default current

  CODE=$HOME/Code
  SITES=$HOME/Herd

  echo " "
  echo "${YELLOW}Two directories will be created if needed, the first one to store the websites at ${SITES}, and the second one to store the code at ${CODE}.${RESET}"
  echo " "

  if ask_clone_repo "OpenClassrooms/WebAcceptanceTests" ${CODE}/wat "the repository for the end to end tests"; then
    if [ ! -d "$CODE" ]; then
      mkdir "$CODE"
    fi
    git clone git@github.com:OpenClassrooms/WebAcceptanceTests.git $CODE/wat
    $(cd $CODE/wat && composer install)
  fi

  if ask_clone_repo "simpleit/SdZv4" ${SITES}/openclassrooms.com "the repository for the web platform"; then
    if [ ! -d "$SITES" ]; then
      mkdir "$SITES"
    fi
    git clone git@github.com:simpleit/SdZv4.git $SITES/openclassrooms.com
  fi

  if ask_clone_repo "OpenClassrooms/ios" ${CODE}/ios "the repository for the ios app"; then
    if [ ! -d "$CODE" ]; then
      mkdir "$CODE"
    fi
    git clone git@github.com:OpenClassrooms/ios.git $CODE/ios
  fi

  if ask_clone_repo "OpenClassrooms/UtilityScripts" ${CODE}/UtilityScripts "the repository for the postman configuration and other utility scripts"; then
    if [ ! -d "$CODE" ]; then
      mkdir "$CODE"
    fi
    git clone git@github.com:OpenClassrooms/UtilityScripts.git $CODE/UtilityScripts
  fi

fi




# ----------------------------------------------
# SECTION 4: Aliases & Paths
# ----------------------------------------------
display_section "Aliases & Paths" 4
 
if ask "Should I install aliases and paths?"; then
  echo " "
  echo "${RED}Actions to take:${RESET}"
  echo "- Please review the file ${DOTFILES_DIR}/aliases.zsh to customize your aliases according to your needs."
  echo "- Please review the file ${DOTFILES_DIR}/paths.zsh to customize your paths according to your needs."

  wait

  rm -rf $HOME/.zshrc
  ln -s $DOTFILES_DIR/.zshrc $HOME/.zshrc

fi

# ----------------------------------------------
# SECTION 4: SSH Key
# ----------------------------------------------
display_section "Set up the apps" 5


echo " "
echo "${RED}Actions to take in iTerm:${RESET}"
echo "If you are painfully moving the cursor one char at a time with arrow keys, replace the key mapping presets with natural text editing."
echo "Settings > Profiles > Keys > Key Mappings > Change the preset to Natural Text Editing"
open -a iTerm

wait

echo " "
echo "${RED}Actions to take in Slack:${RESET}"
echo "Ask your credentials to @Bob in Slack channel #pxt-bob, with these commands:"
echo "@Bob send my DB credentials for staging"
echo "@Bob send my Cloudflare-Access credentials"
open -a Slack

wait

echo " "
echo "${RED}Actions to take in Proxyman:${RESET}"
echo "Import the script file that will pass the Cloudflare Client Id and Cloudflare Secret each time you visit a domain *.openclassrooms.tech."
echo "https://www.notion.so/openclassrooms/Starter-Kit-d8805117553949ffa320bb581d3c5596?pvs=4#7f57356db4c54b84b01b28e0f69de8f9"
open -a Proxyman

wait

echo " "
echo "${RED}Actions to take in Postman:${RESET}"
echo "Import the collection and the 3 env files from UtilityScripts"
echo "https://www.notion.so/openclassrooms/Starter-Kit-d8805117553949ffa320bb581d3c5596?pvs=4#0a7e4f61291f4737aae6db50e3d7f0d3"
open -a Postman

wait

echo " "
echo "${RED}Actions to take in TablePlus:${RESET}"
echo "Download & Import the configuration"
echo "https://www.notion.so/openclassrooms/Starter-Kit-d8805117553949ffa320bb581d3c5596?pvs=4#e528aa1dc71f4472bbaddf344c01ce3b"
open -a TablePlus

wait

cat >> $HOME/.aws/config << 'END'
[profile openclassrooms-sso-staging]
sso_start_url = https://ocr.awsapps.com/start
sso_region = eu-west-1
sso_account_id = 464102534243
sso_role_name = QualityEngineeringQe
region = eu-west-3
output = json
END

echo " "
echo "${RED}Actions to take in WAT .env file:${RESET}"
echo "Replace the configuration"
echo "https://www.notion.so/openclassrooms/Starter-Kit-d8805117553949ffa320bb581d3c5596?pvs=4#227b4db6d04546fba0c6e52ce874cf43"
open -a $HOME/Code/wat/.env

wait


echo " "
echo "${RED}FINISHED LET'S DO SOME CHECKS${RESET}"

wait
