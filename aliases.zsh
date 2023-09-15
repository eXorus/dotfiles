# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'

# Directories
alias dotfiles="cd $DOTFILES"
alias projects="cd $HOME/Code"
alias sites="cd $HOME/Herd"

# Laravel
alias a="php artisan"
alias fresh="php artisan migrate:fresh --seed"
alias tinker="php artisan tinker"
alias seed="php artisan db:seed"
alias serve="php artisan serve"

# Codeception
alias c="./vendor/bin/codecept"
alias cr="clear && c clean && c run"

# Cloudflare Access
alias ot="$HOME/Code/wat/bin/open-tunnel"
alias ct="$HOME/Code/wat/bin/close-tunnel"

# PHP
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# Docker
alias docker-composer="docker-compose"

# Git
alias gs="git status"
alias ga="git add"
alias gaa="git add ."
alias gcm="git checkout main"
alias gcb="git checkout -b"
alias gco="git checkout"
alias gc="git commit -m"
alias gpf="git push --force-with-lease"
alias gd="git diff"
alias gda="git diff ."
alias nah="git reset --hard;git clean -df;"
alias gl="git pull"
alias gp="git push"

