if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Appearance
Plug 'vim-airline/vim-airline' " Useful bottom info bar
Plug 'vim-airline/vim-airline-themes'

" Colorschemes
Plug 'drewtempelmeyer/palenight.vim' " Palenight colorscheme; better contrast when dark
Plug 'altercation/vim-colors-solarized' " Solarized colorscheme
Plug 'morhetz/gruvbox' " Gruvbox, like solarized but warmer and more retro.

" Functionality
Plug 'tpope/vim-sensible' " Sensible defaults
Plug 'scrooloose/nerdtree' " File browser
Plug 'majutsushi/tagbar' " Tag browser
Plug 'sheerun/vim-polyglot' " Language package package

if !exists("g:gui_oni") " Probably won't be using tmux in Oni
    Plug 'christoomey/vim-tmux-navigator' " Seamless navigation for tmux
endif

" IDE
Plug 'tpope/vim-fugitive' " Git wrapper
if !exists("g:gui_oni") " Oni comes with LSP
    Plug 'w0rp/ale' " Lint and complete via external tools - async
endif
Plug 'vim-scripts/auto-pairs-gentle' " Automatically makes surrounds
Plug 'tpope/vim-surround' " Adds bindings for changing surrounds

" Applications
Plug 'jceb/vim-orgmode' " Org-mode support for vim, for journaling + notes

call plug#end()

source ~/.config/nvim/core.vim
