if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

if !exists('g:vscode')
" IDE - PROJECT MANAGEMENT "

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } " Fuzzy finder
  Plug 'junegunn/fzf.vim' " And its vim bindings
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

  Plug 'Lokaltog/neoranger'
  let g:neoranger_viewmode='miller'

  " IDE - VERSION CONTROL "

  Plug 'tpope/vim-fugitive' " Git wrapper
  Plug 'airblade/vim-gitgutter' " Shows git diff in the left gutter. 

  " IDE - LINTING "

  Plug 'w0rp/ale' " Lint and complete via external tools - async
  
  " IDE - Surrounds "
  Plug 'tpope/vim-surround' " Adds bindings for changing surrounds
  Plug 'amcsi/auto-pairs' " Automatically makes surrounds
  let g:AutoPairsFlyMode = 0
  Plug 'frazrepo/vim-rainbow'
  au FileType lisp,cl call rainbow#load()

  " IDE - TAGS "

  Plug 'majutsushi/tagbar' " Tag browser

  " For tagbar compatibility
  let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
  let g:pandoc#filetypes#pandoc_markdown = 0
  
  " IDE - EDITOR FEATURES "

  Plug 'mg979/vim-visual-multi' " Adds sublime-like multicursor. Use ctrl+n and alt+n.
  Plug 'pelodelfuego/vim-swoop' " Adds helm-swoop-like functionality
  let g:swoopUseDefaultKeyMap = 0
  let g:swoopPatternSpaceInsertsWildcard = 0
  let g:swoopAutoInsertMode = 0
  Plug 'DanilaMihailov/beacon.nvim'

  " APPEARANCE "

  Plug 'vim-airline/vim-airline' " Useful bottom info bar
  Plug 'vim-airline/vim-airline-themes'
  let g:airline#extensiosn#fugitiveline#enabled = 1
  let g:airline#extensions#coc#enabled = 1
  let g:airline#extensions#ale#enabled = 1

  Plug 'morhetz/gruvbox'
  let g:gruvbox_italic=1

  " ORGANIZATION/JOURNALING "

  Plug 'vimwiki/vimwiki' " Personal knowledge base and organizer
  let g:vimwiki_list = [{'path': '~/Docs/wiki/', 'auto_export': 0, 'auto_toc': 1, 'template_path': '~/Docs/wiki/templates/', 'template_default': 'default', 'template_ext': '.html', 'syntax': 'markdown', 'ext': '.md'}]
  let g:vimwiki_folding='expr'
  let g:vimwiki_global_ext = 0

  " LANGUAGES "

  Plug 'sheerun/vim-polyglot' " Language package package
  let g:polyglot_disabled = ['latex']

  Plug 'vim-pandoc/vim-pandoc' "vim-pandoc, for markdown->all
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'vim-pandoc/vim-pandoc-after'
  Plug 'dhruvasagar/vim-table-mode'
  let g:pandoc#after#modules#enabled = ["tablemode"]

  Plug 'lervag/vimtex' " LaTeX sucks. Luckily markdown is great.
  let g:vimtex_view_method = 'zathura'
  let g:tex_flavor = 'latex'

  Plug 'calviken/vim-gdscript3' " Somewhat hacky syntax highlighting for GDScript

  " LISP
  Plug 'vlime/vlime', {'rtp': 'vim/'}
endif " End VSCode-excluded plugins

Plug 'tpope/vim-commentary' " Comment and uncomment stuff. gc to use.
Plug 'DanilaMihailov/beacon.nvim'

" IDE - SNIPPETS "

if has("python3")
  Plug 'SirVer/ultisnips' " Snippet engine
  let g:UltiSnipsExpandTrigger="<C-s>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips/"
endif

" IDE - COMPLETION "

if has("node")
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Async completion framework with first-party support for LSP. VSCode-like.
  " use tab and S-tab instead of C-n C-p to navigate completion list
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Coc utilities
  Plug 'neoclide/coc-sources' " coc common sources
  Plug 'neoclide/coc-highlight'

  " viml
  Plug 'neoclide/coc-neco' " viml completion

  " vimtex
  Plug 'neoclide/coc-vimtex' " coc vimtex compatibility

  " Coc plugins for JS/webdev
  Plug 'neoclide/coc-html', { 'for': ['html', 'handlebars', 'razor'] }
  Plug 'neoclide/coc-tsserver', { 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescriptcommon'], 'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', { 'for': ['css', 'scss', 'sass'] }
  Plug 'felippepuhle/coc-graphql', { 'for': 'graphql' }
  Plug 'neoclide/coc-json', { 'for': 'json' }
  Plug 'fannheyward/coc-sql', { 'for': ['sql', 'sqloracle', 'mysql'] }
  Plug 'coc-extensions/coc-svelte', { 'for': 'svelte' }
  Plug 'fannheyward/coc-xml', { 'for': 'xml' }
  Plug 'neoclide/coc-yaml', { 'for': 'yaml' }

  " Coc plugins for Julia
  Plug 'fannheyward/coc-julia', { 'for': 'julia' }

  " Coc plugins for Python
  Plug 'neoclide/coc-python', { 'for': 'python' }
  Plug 'fannheyward/coc-pyright', { 'for': 'python' }

  " Coc plugins for bash/sh
  Plug 'josa42/coc-sh', { 'for': ['sh', 'zsh'] }

  " Coc plugins for C-family
  Plug 'clangd/coc-clangd', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }

  " Coc plugins for C#
  Plug 'coc-extensions/coc-omnisharp', { 'for': ['cs', 'basic'] }
endif

" LANGUAGES "

" Webdev
Plug 'mattn/emmet-vim'

" Navigation and Editing

Plug 'easymotion/vim-easymotion' " Target specific locations when performing motions instead of repeating over and over
Plug 'tpope/vim-repeat' " use . with several plugin commands
Plug 'nathanaelkane/vim-indent-guides' " Highlight separate indentation levels
let g:indent_guides_enable_on_vim_startup = 1
Plug 'osyo-manga/vim-over' " Regex replacement preview

" IDE - EDITOR FEATURES "

Plug 'tpope/vim-commentary' " Comment and uncomment stuff. gc to use.

Plug 'tpope/vim-speeddating' " Increment and decrement dates with <C-a> and <C-x>

" let g:rainbow_active = 1

" IDE - MISC & UTILITY "

Plug 'rhysd/reply.vim'
Plug 'sunaku/vim-shortcut' " Shows all available shortcuts when you've entered an incomplete binding. Depends on fzf.

" CONFIGURATION "

Plug 'tpope/vim-sensible' " Sensible defaults
if !exists("g:gui_oni") " Probably won't be using tmux in Oni
    Plug 'christoomey/vim-tmux-navigator' " Seamless navigation for tmux

endif

call plug#end()

" Source all helper functions
source ~/.config/nvim/helpers.vim

" Source core, which contains actual configuration
source ~/.config/nvim/core.vim

" Source all project.vim files, which contain project-specific configuration
" separate from the project repository
for f in split(glob('~/.config/nvim/projects/*.vim'), '\n')
    exe 'source' f
endfor
