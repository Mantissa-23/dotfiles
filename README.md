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

## Dependencies

Indented lists indicate that a particular program's configuration depends on these packages being installed.
- `i3`
  - `bumblebee-status`: Required for statusline
  - `light`: Required for backlight changer
  - `pactl`: Required for volume changer
- `bspwm`
  - `polybar`
  - `skhd`
  - `rofi`
  - `gnome-terminal`
  - `light`
  - `pactl`
  - `gnome-screenshot`
- `neovim`
  - `python` and `ruby`, both the actual packages and their compatibility modules
  - `ripgrep`
  - `fzf` (possibly)
  - Universal Ctags
  - LSPs for Coc.nvim
- `zsh`
  - `zgen`

## .bashrc and .zshrc

Small shell customizations for UNIX.

## .vimrc

Just redirects sources `~/.config/nvim/init.vim`. This init file is designed to intelligently choose not to load certain plugins or will ignore certain features if they aren't compatible with vanilla vim. I mainly use neovim though, so some stuff has probably slipped through the cracks.
