#!/bin/sh

U=${GITHUB_USER:-$USER}
if ! brew --version; then
    echo Installing Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap caskroom/cask

BOOTSTRAP="$U/bootstrap"
if ! brew tap $BOOTSTRAP; then
    echo "Please fork rphan/bootstrap to $BOOTSTRAP"
    echo 'You can set $GITHUB_USER to override $USER'
    exit
fi

# Bootstrapping circular dependency
[[ ! -z $SKIP_MAS ]] && brew install mas
brew restore

export HOMESHICK_DIR=/usr/local/opt/homeshick
source "$HOMESHICK_DIR/homeshick.sh"

DOTFILES=$U/dotfiles
if [ ! -d $HOME/.homesick/repos/dotfiles ]; then
    if ! homeshick clone $DOTFILES; then
        echo "Please fork rphan/dotfiles to $DOTFILES"
        echo 'You can set $GITHUB_USER to override $USER'
        exit
    fi
fi
homeshick link dotfiles

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
vim +PluginInstall +qall

cat <<EOF
Bootstrap is complete.
Some things may need to be completed by hand.
Please delete $HOME/.finishing_touces after comleting them.

Finishing Touches:

# Get rid of all the default crap on the dock
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others
killall Dock

EOF
[[ -f $HOME/.finishing_touches ]] && cat $HOME/.finishing_touches
