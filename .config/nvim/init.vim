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
Plug 'jeffkreeftmeijer/vim-dim' " Enhanced default colorscheme
"Plug 'morhetz/gruvbox' " Gruvbox, like solarized but warmer and more retro.

" Functionality
Plug 'tpope/vim-sensible' " Sensible defaults
Plug 'scrooloose/nerdtree' " File browser
Plug 'majutsushi/tagbar' " Tag browser
Plug 'sheerun/vim-polyglot' " Language package package
"Plug 'Shougo/denite.nvim' " General completion framework similar to Helm

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
Plug 'pelodelfuego/vim-swoop' " Adds helm-swoop-like functionality
Plug 'terryma/vim-multiple-cursors' " Adds sublime-like multicursor
Plug 'kien/ctrlp.vim' " Fuzzy finder. ctrl+p to use.
Plug 'airblade/vim-gitgutter' " Shows git diff in the left gutter. 
Plug 'tpope/vim-commentary' " Comment and uncomment stuff. gc to use.
Plug 'easymotion/vim-easymotion' " Target specific locations when performing motions instead of repeating over and over
Plug 'nathanaelkane/vim-indent-guides' " Highlight separate indentation levels
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'tpope/vim-speeddating' " Increment and decrement dates with <C-a> and <C-x>
Plug 'SirVer/ultisnips' " Snippet engine
Plug 'honza/vim-snippets' " And accompanying snippets

" Deoplete completion plugin
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Applications
Plug 'jceb/vim-orgmode' " Org-mode support for vim, for journaling + notes

" C# Development
Plug 'OmniSharp/omnisharp-vim'

call plug#end()

source ~/.config/nvim/core.vim
