# dotfiles

A collection of UNIX/Windows dotfiles for direct installation to /home. Setup is based on StreakyCobra's setup, described [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/). Install with the following series of commands:

```bash
git clone --bare https://github.com/Mantissa-23/dotfiles.git $HOME/.cfg
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
```

If this fails, rename any default conflicting files if you would like to keep their contents, or remove them if you don't care.

Alternatively, download and run the [install script](https://github.com/Mantissa-23/dotfiles/blob/master/install.sh).

Please ensure all dependencies are installed before using a particular dotfile.

## Text Editors

I've tried Emacs, VSCode, a handful of IDEs and Vim. I pretty consistently only use Vim nowadays, just because it's been the most flexible, configurable, intuitive, and most importantly fun out of all of them.

## nvim

My own personal neovim configuration.

### Dependencies

Indented lists indicate that a particular program's configuration depends on these packages being installed.
- `i3`
  - `bumblebee-status`: Required for statusline
  - `light`: Required for backlight changer
  - `pactl`: Required for volume changer
- `neovim` (with all optional dependencies such as python and ruby)
  - `cmake`: Required to build ag
- `zsh`
  - `oh-my-zsh`
  - `zsh-autosuggestions`
  - `zsh-history-substring-search`
  - `zsh-syntax-highlighting`

## .bashrc and .zshrc

Small shell customizations for UNIX. Reliant on zgen.

## .vimrc

Just redirects sources `~/.config/nvim/init.vim`. This init file is designed to intelligently choose not to load certain plugins or will ignore certain features if they aren't compatible with vanilla vim. I mainly use neovim though, so some stuff has probably slipped through the cracks.

## .tmux.conf

An absolutely terrible tmux configuration file. Please do not use this.

## .emacs.d

Don't use my Emacs config.

## AppData/Romaing/Code/{User,Oni}

Personal configuration for VSCode and Oni, respectively. Both of these configs are fairly immature and terrible, the former because I just don't like VSCode that much (even though its completion and documentation-on-hover is fantastic) and the latter because Oni itself is immature.
