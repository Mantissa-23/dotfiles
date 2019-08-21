if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Appearance
Plug 'vim-airline/vim-airline' " Useful bottom info bar
Plug 'vim-airline/vim-airline-themes'
"let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensiosn#fugitiveline#enabled = 1

" Colorschemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
let g:gruvbox_italic=1

" Usability
Plug 'sunaku/vim-shortcut' " Shows all available shortcuts when you've entered an incomplete binding. Depends on fzf.

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } " Fuzzy finder
Plug 'junegunn/fzf.vim' " And its vim bindings
let g:fzf_history_dir = '~/.local/share/fzf-history'

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
  " Restrict ale to only using omnisharp for C# linting
  let g:ale_linters = {'cs': ['OmniSharp']}
  let g:ale_completion_enabled = 1

  Plug 'w0rp/ale' " Lint and complete via external tools - async
endif

Plug 'amcsi/auto-pairs' " Automatically makes surrounds
let g:AutoPairsFlyMode = 0
"let g:AutoPairs = {'`': '`//s', '"': '"//s', '{': '}//s', '''': '''//s', '(': ')//s', '[': ']//s'} " Disable multiline autpairing

Plug 'tpope/vim-surround' " Adds bindings for changing surrounds

Plug 'pelodelfuego/vim-swoop' " Adds helm-swoop-like functionality
let g:swoopUseDefaultKeyMap = 0
let g:swoopPatternSpaceInsertsWildcard = 0
let g:swoopAutoInsertMode = 0

Plug 'terryma/vim-multiple-cursors' " Adds sublime-like multicursor. Use ctrl+n and alt+n.
"Plug 'kien/ctrlp.vim' " Fuzzy finder. ctrl+p to use.
Plug 'airblade/vim-gitgutter' " Shows git diff in the left gutter. 
Plug 'tpope/vim-commentary' " Comment and uncomment stuff. gc to use.
Plug 'easymotion/vim-easymotion' " Target specific locations when performing motions instead of repeating over and over
Plug 'nathanaelkane/vim-indent-guides' " Highlight separate indentation levels
Plug 'haya14busa/incsearch.vim' " Incremental search
Plug 'haya14busa/incsearch-easymotion.vim' " Compatibility with easymotion
Plug 'osyo-manga/vim-over' " Regex replacement preview
Plug 'tpope/vim-speeddating' " Increment and decrement dates with <C-a> and <C-x>

Plug 'SirVer/ultisnips' " Snippet engine
Plug 'honza/vim-snippets' " And accompanying snippets
"let g:UltiSnipsExpandTrigger = "<C-CR>"
"let g:UltiSnipsListSnippets = "<C-u>"
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger=""
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips/"

" Deoplete completion plugin
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#deoplete_onmni_patterns = get(g:, 'deoplete#force_omni_input_patterns', {})
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"let g:deoplete#sources = {}
"let g:deoplete#sources._=['omni', 'buffer', 'member', 'tag', 'ultisnips', 'file']

" Applications
Plug 'jceb/vim-orgmode' " Org-mode support for vim, for journaling + notes
Plug 'vimwiki/vimwiki' " Personal knowledge base and organizer
let g:vimwiki_list = [{'path': '~/Docs/wiki/', 'auto_export': 0, 'auto_toc': 1, 'template_path': '~/Docs/wiki/templates/', 'template_default': 'default', 'template_ext': '.html'}]
let g:vimwiki_folding='expr'

" C# Development
"Plug 'OmniSharp/omnisharp-vim'
"if has('win32')
  "let g:OmniSharp_server_path = 'C:\Omnisharp\omnisharp.http-win-x64\OmniSharp.exe'
"endif
"let g:OmniSharp_translate_cygwin_wsl = 1
"let g:OmniSharp_server_path = '/mnt/c/tools/Omnisharp/omnisharp/OmniSharp.exe'
"let g:OmniSharp_translate_cygwin_wsl = 1
" let g:OmniSharp_proc_debug = 1
" let g:OmniSharp_loglevel = 'debug'

" Python and Jupyter

"Plug 'broesler/jupyter-vim'

" GDScript Development

Plug 'calviken/vim-gdscript3'
" REPL MAGIC

Plug 'metakirby5/codi.vim'

call plug#end()

" Source all helper functions
source ~/.config/nvim/helpers.vim
" Source core, which contains actual configuration
source ~/.config/nvim/core.vim
" Source all project.vim files
for f in split(glob('~/.config/nvim/projects/*.vim'), '\n')
    exe 'source' f
endfor
