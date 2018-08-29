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

## Text Editors

I use both Emacs and NeoVim depending on what I'm up to. Vim is generally for short edits, configuration, or if I must work remotely over an SSH (I haven't learned to use Emacs's Tramp-Mode yet). I also use Vim when I need to work with pipes (via moreutil's vipe) or if I'm going to get things faster with a BASH terminal than with an IDE. Emacs I generally use for my personal machine and development. I occasionally switch between which one is my favorite; as a result, one configuration may be more mature than the other at any given time (as of writing, Emacs is more mature).

Both are vim-editing-style-biased; the Emacs configuration is evil-mode-centric. Both rely heavily on a rigorous and aggressive abuse of `SPC` as `<leader>`, just as with Spacemacs. Both are intended to be as lean as possible and do only what I need them to do, minimizing bloat otherwise.

## nvim

My own personal neovim configuration.

### Dependencies

- vim-plug
- cmake
- neovim (with all optional dependencies such as python and ruby)

## .emacs.d

My own personal Emacs configuration. Emacs and nvim configurations are designed to be fairly similar in terms of what keybindings do what, however do to intrinsic differences in the editors there will be feature differences between the two, and due to my laziness and also flip-flopping between which one is my favorite editor, there will be differences in the keybindings.

### Dependencies
- ripgrep
- npm: javascript-typescript-langserver
- lean

### Dependencies

- hunspell or similar
- ripgrep

## .bashrc and .zshrc

Small shell customizations for UNIX

## .vimrc

Just redirects vim initialization to `~/.config/nvim/init.vim`. This init file is designed to intelligently choose not to load certain plugins or will ignore certain features if they aren't compatible with vanilla vim.

## .tmux.conf

An absolutely terrible tmux configuration file. Please do not use this.

## AppData/Romaing/Code/{User,Oni}

Personal configuration for VSCode and Oni, respectively. Both of these configs are fairly immature and terrible, the former because I just don't like VSCode that much (even though its completion and documentation-on-hover is fantastic) and the latter because Oni itself is immature.

Ensure all of these are installed before using.
