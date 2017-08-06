#!/bin/sh

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap rphan/bootstrap

# Install Homeschick
# FIXME - Test for Idempotent-ness
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
homeshick clone rphan/dotfiles

brew restore
brew restore-cask
brew restore-apps

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
vim +PluginInstall +qall

echo <<EOF
Launch these once:
open /usr/local/Caskroom/lastpass/latest/LastPass\ Installer.app
open /Applications/ShiftIt.app
open /Applications/Caffeine.app

Set your fonts for iterm to be:
ASCII 12pt Meslo LG S DZ Regular for Powerline -- +AA
NON-ASCII 12.2pt Meslo LG S DZ Regular for Powerline -- +AA

Don't forget to edit your chrome settings!!

# Get rid of all the default crap on the dock
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others
killall Dock
EOF
