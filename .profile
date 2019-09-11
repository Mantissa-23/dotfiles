# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export DISPLAY=":0"

export EDITOR="/usr/bin/nvim"

export AUTHOR="Dylan Culfogienis <dylanculfogienis@gmail.com>"

export JOURNAL="~/Docs/Writing/Journal"

machine="$(uname -s)"

case "${machine}" in
  Linux*)   MACHINE=Linux;;
  Darwin*)  MACHINE=Mac;;
  CYGWIN*)  MACHINE=Cygwin;;
  MINGW*)   MACHINE=MinGw;;
  *)        MACHINE="UNKNOWN:${machine}"
esac

export MACHINE

export PATH=$PATH:~/.bin
export PATH=$PATH:~/.build/lammps/build

# Cocos2d paths

export PATH=$PATH:~/.bin/cocos2d/cocos2d-x-3.17.2/tools/cocos2d-console/bin/
# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT="~/.bin/cocos2d/cocos2d-x-3.17.2/tools/cocos2d-console/bin"
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT="~/.bin/cocos2d"
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT="~/.bin/cocos2d/cocos2d-x-3.17.2/templates"
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

export PATH=~/Zotero/styles:$PATH
