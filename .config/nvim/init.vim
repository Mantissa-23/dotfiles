if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Appearance
Plug 'vim-airline/vim-airline' " Useful bottom info bar
Plug 'vim-airline/vim-airline-themes'
Plug 'drewtempelmeyer/palenight.vim' " Palenight colorscheme; better contrast when dark
Plug 'altercation/vim-colors-solarized' " Solarized colorscheme

" Functionality
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-sensible' " Sensible defaults
Plug 'scrooloose/nerdtree' " File browser
Plug 'majutsushi/tagbar' " Tag browser
Plug 'sheerun/vim-polyglot' " Language package package
if has("python") && v:version > 741578
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' } " Keyword completion
endif
"Plug 'neomake/neomake' " Lint via makeprg - async
Plug 'w0rp/ale' " Lint via external tools - async
"Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/auto-pairs-gentle' " Automatically makes surrounds
Plug 'tpope/vim-surround' " Adds bindings for changing surrounds

call plug#end()

source ~/.config/nvim/core.vim
