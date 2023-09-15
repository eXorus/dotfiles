#!/bin/sh

echo "Cloning repositories..."

git config --global push.default current

CODE=$HOME/Code
SITES=$HOME/Herd

# Create a project directories
mkdir $HOME/Code
mkdir $HOME/Herd

# Sites
git clone git@github.com:eXorus/codeception.cloud.git $SITES/codeception.cloud
git clone git@github.com:php-mime-mail-parser/emailparser-tools.git $SITES/emailparser.tools
git clone git@github.com:simpleit/SdZv4.git $SITES/openclassrooms.com

# Code
git clone git@github.com:php-mime-mail-parser/php-mime-mail-parser.git $CODE/pmmp
git clone git@github.com:OpenClassrooms/WebAcceptanceTests.git $CODE/wat
git clone git@github.com:OpenClassrooms/UtilityScripts.git $CODE/UtilityScripts
git clone git@github.com:OpenClassrooms/ios.git $CODE/ios




 
