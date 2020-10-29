"                               Aesthetics
" ----------------------------------------------------------------------------
" nocompatible required for non-neovim
set nocompatible
syntax on
filetype plugin on

"set term=screen-256color
set t_ut=
set termguicolors

" Default to dark scheme
call DarkScheme()

" Color column 80, for code formatting
set colorcolumn=80

" Disable messages for completion menu
set shortmess+=c

"                         General Editor Configuration
" ----------------------------------------------------------------------------

" Automatically read changes to a file
set autoread

" Safeguarded syntax enable
if !exists("g:syntax_on")
    syntax enable
endif

" Generic Tab Settings. I like 2-tab, it's compact
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent
" Orgmode tabs
autocmd Filetype org setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent
autocmd BufEnter,BufNew *.gd setlocal noexpandtab tabstop=4 shiftwidth=4 autoindent
"
" LaTeX tabs
autocmd Filetype tex setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent

" Enable line number display, always
set number
set relativenumber
set title

" Do not wrap lines in the middle of words
set linebreak

" Do not wrap at all by default.
set nowrap
set sidescroll=1

" But wrap for non-code file types
au Filetype markdown,tex setlocal wrap

" Split right and below, instead of left and above. Left and above is for
" aliens.
set splitright splitbelow

" Enable generic code folding based on indentations.
set foldmethod=indent
set foldnestmax=10
set nofoldenable " Disable folding
set foldlevel=20
"autocmd Filetype vimwiki let &l:foldlevel=max(map(range(1, line('$')), 'foldlevel(v:val)'))

" Set scrolloff, so that at least n lines are displayed above and below the
" cursor.
set scrolloff=10

" Hit enter-enter to exit commenting. Works only for C/Ruby/Python
imap <expr> <CR> EnterEnter()

" Set both ignorecase and smartcase so that all-lowercase searches will
" ignore case
set ignorecase
set smartcase

" Enable incremental search
set incsearch

" Reduce update time to 300 from 4000 for diagnostics
set updatetime=300

" Turn on spelling for md, wiki and org files
autocmd BufRead,BufNewFile *.md,*.wiki,*.org setlocal spell
"                           General Keymappings
" ----------------------------------------------------------------------------

" Map 'fd' to the escape key, as in Spacemacs
:inoremap fd <Esc>
:vnoremap fd <Esc>
if has('nvim')
    :tnoremap fd <C-\><C-n>
endif

" Make tab and window navigation more sensible
" Functionality usually covered by vim-tmux-navigator
" Map only if using GUI
if exists("g:gui")
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
endif

" Shift windows around with C-S-...
nnoremap <M-h> <C-w>H
nnoremap <M-j> <C-w>J
nnoremap <M-k> <C-w>K
nnoremap <M-l> <C-w>L

" Use alt + directions to move left and right
"nnoremap <M-h> :tabp<CR>
"nnoremap <M-l> :tabn<CR>

" Scroll through visible lines as opposed to numbered lines; but only in
" markdown.
" autocmd FileType markdown   nnoremap j gj
" autocmd FileType markdown   nnoremap k gk

" Add // in visual mode to search for highlighted text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Non-leader Keymappings
" ----------------------------------------------------------------------------

nmap <C-;> :execute "normal! [s<CR>"
" Leader Keymappings
" ----------------------------------------------------------------------------

" ALL HAIL OUR GLORIOUS ETERNAL LEADER, THE SPACEBAR, PRAISE BE TO HIM
let mapleader=" "
let maplocalleader=","

" Prefix Glossary
" a         - Applications
" aj        - Journal
" as        - Shells/Terminals
" b         - Buffers
" c         - Comments
" C         - Compile
" e         - Errors/Linting/Language Diagnostics
" f         - Files
" fe        - Edit configuration
" g         - Git/VCS
" h         - Help
" i         - Insertion/Snippets
" p         - Project
" r         - Refactor
" s         - Search
" sa        - ag
" j         - jump-to (IDE style)
" sg        - grep
" sk        - ack
" st        - pt
" sw        - web
" t         - toggles
" T         - colorscheme toggles
" w         - windows
"  wt       - tabs

" a         - Applications
" -----------------------------------
nmap <leader>ajj :call JNewEntry()<CR>
"nmap <leader>avj :call JViewEntry()<CR>

nmap <leader>att :terminal<CR>
nmap <leader>atv :vsp<CR>:terminal<CR>
nmap <leader>ats :sp<CR>:terminal<CR>

nmap <leader>aww <Plug>VimwikiIndex
nmap <leader>awt <Plug>VimwikiTabIndex
nmap <leader>aws <Plug>VimwikiUISelect
nmap <leader>awc :VimwikiTOC<CR>
nmap <leader>aji <Plug>VimwikiDiaryIndex
"nmap <leader>ajj <Plug>VimwikiMakeDiaryNote
nmap <leader>ajj :call JNewEntry()<CR>
nmap <leader>ajt <Plug>VimwikiTabMakeDiaryNote
nmap <leader>ajy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <leader>ajm <Plug>VimwikiMakeTomorrowDiaryNote

nmap <leader>ar :Codi!!<CR>
" as        - Shells/Terminals
" -----------------------------------
" b         - Buffers
" -----------------------------------
" Close current buffer and the window it's in
nmap <leader>bd :bdelete<CR> 
nmap <leader>bd! :bdelete!<CR> 
nmap <leader>bn :bn<CR>
nmap <leader>bp :bp<CR>
" c         - Comments
" -----------------------------------
nmap <leader>cc gcc
vmap <leader>c gc
" C         - Compile
" -----------------------------------
xmap <leader>Cc <Plug>SlimeRegionSend
nmap <leader>Cc <Plug>SlimeParagraphSend

" d         - Diagnostics
nmap <leader>dc 

" -----------------------------------
nmap <leader>Cnm :Neomake!<CR>
" e         - Errors/Linting/Language Diagnostics
nmap <leader>en :ALENextWrap<CR>
nmap <leader>ep :ALEPreviousWrap
nmap <leader>egg :ALEFirst<CR>
nmap <leader>eG :ALELast<CR>
nmap <leader>ed :ALEDetail<CR>
" -----------------------------------
" f         - Files
" -----------------------------------

nmap <leader>fr :History<CR>
nmap <leader>fF :RangerCurrentFile<CR>
nmap <leader>ff :Files<CR>
nmap <leader>fd :call fzf#run(fzf#wrap({'source': 'fasd -d -R', 'sink': { line -> execute('cd '.split(line)[-1]) }}))<CR>
nmap <leader>fgf :GFiles<CR>
nmap <leader>fb :Buffers<CR>
nmap <leader>frg :Rg 
" nmap <leader>ft :Tags
" nmap <leader>fT :tag<CR>
" fe        - Edit configuration
" -----------------------------------
nmap <leader>fei :vsp ~/.config/nvim/init.vim<CR>
nmap <leader>fec :vsp ~/.config/nvim/core.vim<CR>
nmap <leader>fep :vsp ~/.config/nvim/projects/<CR>
nmap <leader>feh :vsp ~/.config/nvim/helpers.vim<CR>
nmap <leader>fer :so $MYVIMRC<CR>
nmap <leader>fes :UltiSnipsEdit<CR>
" g         - Git/VCS
" -----------------------------------
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gd :Gdiff<CR>
" h         - Help
" -----------------------------------
nmap <leader>h<leader> :helpgrep 
" i         - Insertion/Snippets
" -----------------------------------
"nmap <leader>isl call UltiSnips#ListSnippets()<CR>
nmap <leader>it :pu=strftime('%c')<CR>
imap <c-p><c-p> <plug>(fzf-complete-path)
" j         - Jump; File navigation
" -----------------------------------
nmap <leader>jj :TagbarToggle<CR>
nmap <leader>jd <Plug>(coc-definition)
nmap <leader>jy <Plug>(coc-type-definition)
nmap <leader>ji <Plug>(coc-implementation)
nmap <leader>jr <Plug>(coc-references)
" nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" nnoremap <silent> <leader>je  :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>jc  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>jo  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>js  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
" nmap <leader>js :GscopeFind s <C-R><C-W><cr>
" nmap <leader>jg :GscopeFind g <C-R><C-W><cr>
" nmap <leader>jc :GscopeFind c <C-R><C-W><cr>
" nmap <leader>jt :GscopeFind t <C-R><C-W><cr>
" nmap <leader>je :GscopeFind e <C-R><C-W><cr>
" nmap <leader>jf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" nmap <leader>ji :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" nmap <leader>jd :GscopeFind d <C-R><C-W><cr>
" nmap <leader>ja :GscopeFind a <C-R><C-W><cr>
" p         - Project
" -----------------------------------

" r         - Refactor
" -----------------------------------

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>rf <Plug>(coc-format-selected)
nmap <leader>rf <Plug>(coc-format-selected)
nmap <leader>rs :%s/\s\+$//e<cr>
vmap <leader>rs :s/\s\+$//e<cr>

" s         - Search
" -----------------------------------
nmap <leader>ss :call Swoop()<CR>
vmap <leader>ss :call SwoopSelection()<CR>
nmap <leader>sS :call SwoopMulti()<CR>
vmap <leader>sS :call SwoopMultiSelection()<CR>
" -----------------------------------
" sw        - web
" -----------------------------------
" t         - toggles
" -----------------------------------
" Toggle spelling
"nmap <leader> ts :call ToggleSpelling()<CR>
" T         - colorscheme toggles
" -------------------------------------------------
nmap <leader>Ts :call ToggleScheme()<CR>
" w         - windows
" -------------------------------------------------
nmap <leader>wh <C-w>h
nmap <leader>wj <C-w>j
nmap <leader>wk <C-w>k
nmap <leader>wl <C-w>l

nmap <leader>wH <C-w>H
nmap <leader>wJ <C-w>J
nmap <leader>wK <C-w>K
nmap <leader>wL <C-w>L
"  wt       - tabs
" -------------------------------------------------
" tab controls
nmap <leader>wts :tab split<CR>
nmap <leader>wtc :tabc<CR>
nmap <leader>wtn gt
nmap <leader>wtp gT

if exists("shortcuts")
  Shortcut fallback to shortcut menu on partial entry
        \ noremap <silent> <Leader> :Shortcuts<Return>

  "Shortcut! <leader>ajj    new journal entry
  Shortcut! <leader>avj    open current journal entry
  Shortcut! <leader>att    open terminal in current window
  Shortcut! <leader>atv    open terminal in vsplit
  Shortcut! <leader>ats    open terminal in split
  Shortcut! <leader>bd     delete buffer
  Shortcut! <leader>bd!    delete buffer without saving
  Shortcut! <leader>Cnm    make project with neomake
  Shortcut! <leader>ft     open NERDTree
  Shortcut! <leader>fnb    boomark NERDTree
  Shortcut! <leader>fr     find file in recents
  Shortcut! <leader>ff     find file
  Shortcut! <leader>fgf    find in git files
  Shortcut! <leader>fb     find in buffers
  Shortcut! <leader>fei    open init.vim
  Shortcut! <leader>fec    open core.vim
  Shortcut! <leader>fer    reload init.vim
  Shortcut! <leader>gs     git status
  Shortcut! <leader>gc     git commit
  Shortcut! <leader>gl     git log
  Shortcut! <leader>gp     git push
  Shortcut! <leader>gd     git diff
  Shortcut! <leader>ss     swoop
  Shortcut! <leader>ss     swoop selection
  Shortcut! <leader>sS     swoop all open buffers
  Shortcut! <leader>sS     swoop selection in all open buffers
  Shortcut! <leader>Ts     switch between light and dark colorschemes
  Shortcut! <leader>wh     focus left
  Shortcut! <leader>wj     focus down
  Shortcut! <leader>wk     focus up
  Shortcut! <leader>wl     focus right
  Shortcut! <leader>wH     move split to left
  Shortcut! <leader>wJ     move split to down
  Shortcut! <leader>wK     move split to up
  Shortcut! <leader>wL     move split to right
  Shortcut! <leader>wts    open current split in new tab
  Shortcut! <leader>wtc    close current tab
  Shortcut! <leader>wtt    go to next tab
  Shortcut! <leader>wtT    go to previous tab
  Shortcut! <leader>jj     tagbar toggle
  Shortcut! <leader>js     find symbol references under cursor
  Shortcut! <leader>jg     find symbol definition under cursor
  Shortcut! <leader>jc     functions called by this function
  Shortcut! <leader>jt     functions calling this function
  Shortcut! <leader>je     find string under cursor
  Shortcut! <leader>jf     find egrep pattern under cursor
  Shortcut! <leader>ji     find filename under cursor
  Shortcut! <leader>jd     find files #including file name under cursor
  Shortcut! <leader>ja     find places where current symbol is assigned

endif
