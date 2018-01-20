call plug#begin('~/.local/share/nvim/plugged')

" Appearance
Plug 'vim-airline/vim-airline' " Useful bottom info bar
Plug 'vim-airline/vim-airline-themes'
Plug 'drewtempelmeyer/palenight.vim' " Solarized colorscheme

" Functionality
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-sensible' " Sensible defaults
Plug 'scrooloose/nerdtree' " File browser
Plug 'majutsushi/tagbar' " Tag browser
Plug 'sheerun/vim-polyglot' " Language package package
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' } " Keyword completion

call plug#end()

" Aesthetics
" ----------
set background=dark
colorscheme palenight

" General Configuration 
" ---------------------

" Safeguarded syntax enable
if !exists("g:syntax_on")
    syntax enable
endif

" Tab settings
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent

" Enable line number display
set number
set title

" Do not wrap lines in the middle of words
set linebreak

" Split right and below, instead of left and above
set splitright splitbelow

" Custom keymappings
" ------------------

" Make tab and window navigation more sensible
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Scroll through visible lines as opposed to numbered lines
nnoremap j gj
nnoremap k gk

" Leader controls
let mapleader=","
nmap <leader>nn :NERDTreeToggle<CR>
nmap <leader>tt :TagbarToggle<CR>
" Add control for quickly opening init.vim
nmap <leader>erc :sp ~/.config/nvim/init.vim<CR>

" Plugin configuration
