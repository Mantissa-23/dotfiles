# $HOME/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if $HOME/.bash_profile or $HOME/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export DISPLAY=":0"

export EDITOR=nvim

export FILEMANAGER=ranger

export AUTHOR="Dylan Culfogienis <dylanculfogienis@gmail.com>"

export JOURNAL="$HOME/Docs/Writing/Journal"

machine="$(uname -s)"

case "${machine}" in
  Linux*)   MACHINE=Linux;;
  Darwin*)  MACHINE=Mac;;
  CYGWIN*)  MACHINE=Cygwin;;
  MINGW*)   MACHINE=MinGw;;
  *)        MACHINE="UNKNOWN:${machine}"
esac

export MACHINE

export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.opt

# Cocos2d paths

export PATH=$HOME/Zotero/styles:$PATH

# Flutter exec
export PATH=$HOME/.build/flutter/bin:$PATH

# Android SDK
export ANDROID_HOME=$HOME/.build/Android/Sdk

# Ruby executables
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH

# Mac NVM setup

if [[ $(uname -s) == Darwin ]]
then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
fi

# Work Config

test -f ~/.localprofile && source ~/.localprofile

# Ruby stuff

export PATH="~/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
