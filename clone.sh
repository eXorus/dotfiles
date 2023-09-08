#!/bin/sh

echo "Cloning repositories..."

CODE=$HOME/Code
SITES=$HOME/Herd

# Sites
git clone git@github.com:eXorus/codeception.cloud.git $SITES/codeception.cloud
git clone git@github.com:php-mime-mail-parser/emailparser-tools.git $SITES/emailparser-tools

# Code
git clone git@github.com:php-mime-mail-parser/php-mime-mail-parser.git $CODE/php-mime-mail-parser
git clone git@github.com:OpenClassrooms/WebAcceptanceTests.git $CODE/WebAcceptanceTests
