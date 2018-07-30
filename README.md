# dotfiles

A collection of UNIX/Windows dotfiles for direct installation to /home. Setup is based on StreakyCobra's setup, described [here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/). Install with the following series of commands:

```bash
git clone --bare https://github.com/Mantissa-23/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
```

If this fails, rename any default conflicting files if you would like to keep their contents, or remove them if you don't care.

## nvim

My own personal neovim configuration, with a focus on simplicity and rigorous abuse of a `<space>` `<leader>`. Meant to be cloned right into `~/.config` on new computers, distros and servers, with minimal setup and finicking.

## Dependencies

- vim-plug
- cmake
- neovim (with all optional dependencies such as python) 

Ensure all of these are installed before using.

