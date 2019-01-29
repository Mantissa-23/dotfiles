"                               Aesthetics
" ----------------------------------------------------------------------------

"set term=screen-256color
set t_ut=

" Toggle colorscheme between dark and light schemes, for quick switching
" between dark and light environments.

function! DarkScheme()
    colorscheme palenight
    set background=dark
endfunction

function! LightScheme()
    colorscheme solarized
    set background=light
endfunction

function! ToggleScheme()
    if &background ==# 'light'
        call DarkScheme()
    elseif &background ==# 'dark'
        call LightScheme()
    endif
endfunction

" Default to dark scheme
call DarkScheme()

" Color column 80, for code formatting
set colorcolumn=80

"                         General Editor Configuration
" ----------------------------------------------------------------------------

" Automatically read changes to a file
set autoread

" Safeguarded syntax enable
if !exists("g:syntax_on")
    syntax enable
endif

" Generic Tab Settings
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent

" Enable line number display, always
set number
set relativenumber
set title

" Do not wrap lines in the middle of words
set linebreak

" Split right and below, instead of left and above
set splitright splitbelow

" Enable generic code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Set scrolloff, so that at least n lines are displayed above and below the
" cursor.
set scrolloff=10

" Hit enter-enter to exit commenting. Works only for C/Ruby/Python
function! EnterEnter()
	if getline(".") =~ '^\s*\(//\|#\|"\)\s*$'
		return "\<C-u>"
	else
		return "\<CR>"
	endif
endfunction

imap <expr> <CR> EnterEnter()

" Set both ignorecase and smartcase so that all-lowercase searches will
" ignore case
set ignorecase
set smartcase

"                           Plugin Configuration
" ----------------------------------------------------------------------------

" FILE SYSTEM & SCM

" BUILD, LINT, CHECK

" Neomake setup
let g:neomake_cpp_enabled_markers = ['gcc']
let g:neomake_c_enabled_markers = ['gcc']

" call neomake#configure#automake('nrwi', 500)

" YCM Setup
let g:ycm_collect_identifiers_from_tags_files = 1

" Auto-Pair Setup
let g:AutoPairsFlyMode = 0

" AESTHETIC & INFORMATION

" Airline Customization
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensiosn#fugitiveline#enabled = 1

" NEOMAKE

" Function to automatically set makeprg, valuable for C++ and C
function! g:BuildInSubDir(buildsubdir)
    " Sets makeprg base dir
    let toplevelpath = FindTopLevelProjectDir()
    let builddir = toplevelpath . a:buildsubdir
    let makeprgcmd = 'make -C ' . builddir
    if builddir !=? "//build"
        let &makeprg=makeprgcmd
    endif
endfunction

function! FindTopLevelProjectDir()
    " Searches for a .git directory upward till root.
    let isittopdir = finddir('.git')
    if isittopdir ==? ".git"
        return getcwd()
    endif
    let gitdir = finddir('.git', ';')
    let gitdirsplit = split(gitdir, '/')
    let toplevelpath = '/' . join(gitdirsplit[:-2],'/')
    return toplevelpath
endfunction

" Only use out-of-source build if no in-source build is detected.
if globpath('.','Makefile') == ''
    autocmd BufNewFile,BufRead *.cpp,*.c call g:BuildInSubDir("/build")
endif

" vim-swoop configuration

let g:swoopUseDefaultKeyMap = 0
let g:swoopPatternSpaceInsertsWildcard = 0
let g:swoopAutoInsertMode = 0

" ale configuration

" Restrict ale to only using omnisharp for linting
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

" UltiSnips configuration

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger=""

let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetsDir="~/.config/nvim"

"                           Custom Functions
" ----------------------------------------------------------------------------

function! JFilename()
    let journaldir = '~/Docs/Org/Journal/'
    let name = strftime('%Y%m%d.org')
    return journaldir . name
endfunction

function! JNewEntry()
    let filename = JFilename()

    if !(bufwinnr(filename) == bufnr('%'))
        execute ":vsp" filename
    endif
    
    " If new file unopened in buffer, add date header
    if empty(glob(filename))
        execute "normal! A* " . strftime('%A, %m/%d/%y')
    endif

    execute "normal! Go** " . strftime('%H:%M ')
endfunction

function! JViewEntry()
    let filename = JFilename()
    execute ":vsp" filename
endfunction

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
" Map only if using oni, which doesn't require vim-tmux-navigator
if exists("g:gui_oni")
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
endif

" Use alt + directions to move left and right
nnoremap <M-h> :tabp<CR>
nnoremap <M-l> :tabn<CR>

" Scroll through visible lines as opposed to numbered lines
nnoremap j gj
nnoremap k gk

" Add // in visual mode to search for highlighted text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Leader Keymappings
" ----------------------------------------------------------------------------

" ALL HAIL OUR GLORIOUS ETERNAL LEADER, THE SPACEBAR, PRAISE BE TO HIM
let mapleader=" "

Shortcut fallback to shortcut menu on partial entry
      \ noremap <silent> <Leader> :Shortcuts<Return>

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
" s         - Search
" sa        - ag
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
Shortcut new journal entry
      \ nmap <leader>ajj :call JNewEntry()<CR>
Shortcut open current journal entry
      \ nmap <leader>avj :call JViewEntry()<CR>
Shortcut open terminal in current window
      \ nmap <leader>att :terminal<CR>
Shortcut open terminal in vsplit
      \ nmap <leader>atv :vsp<CR>:terminal<CR>
Shortcut open terminal in split
      \ nmap <leader>ats :sp<CR>:terminal<CR>
" as        - Shells/Terminals
" -----------------------------------
" b         - Buffers
" -----------------------------------
" Close current buffer and the window it's in
Shortcut delete buffer
      \ nmap <leader>bd :bdelete<CR> 
Shortcut delete buffer without saving
      \ nmap <leader>bd! :bdelete!<CR> 

" c         - Comments
" -----------------------------------
" C         - Compile
" -----------------------------------

Shortcut make project with neomake
      \ nmap <leader>Cnm :Neomake!<CR>

" e         - Errors/Linting/Language Diagnostics
" -----------------------------------
" f         - Files
" -----------------------------------

Shortcut open NERDTree
      \ nmap <leader>ft :NERDTreeToggle<CR>
Shortcut boomark NERDTree
      \ nmap <leader>fnb :Bookmark 

Shortcut find file in recents
      \ nmap <leader>fr :History<CR>
Shortcut find file
      \ nmap <leader>ff :Files<CR>
Shortcut find in git files
      \ nmap <leader>fgf :GFiles<CR>
Shortcut find in buffers
      \ nmap <leader>fb :Buffers<CR>

" fe        - Edit configuration
" -----------------------------------

Shortcut open init.vim
      \ nmap <leader>fei :vsp ~/.config/nvim/init.vim<CR>
Shortcut open core.vim
      \ nmap <leader>fec :vsp ~/.config/nvim/core.vim<CR>

Shortcut reload init.vim
      \ nmap <leader>fer :so $MYVIMRC<CR>

" g         - Git/VCS
" -----------------------------------

Shortcut git status
      \ nmap <leader>gs :Gstatus<CR>
Shortcut git commit
      \ nmap <leader>gc :Gcommit<CR>
Shortcut git log
      \ nmap <leader>gl :Glog<CR>
Shortcut git push
      \ nmap <leader>gp :Gpush<CR>
Shortcut git diff
      \ nmap <leader>gd :Gdiff<CR>

" h         - Help
" -----------------------------------
" i         - Insertion/Snippets
" -----------------------------------
" j         - Jump; File navigation
" -----------------------------------

Shortcut tagbar toggle
      \ nmap <leader>jt :TagbarToggle<CR>

" p         - Project
" -----------------------------------
" s         - Search
" -----------------------------------
Shortcut swoop
      \ nmap <leader>ss :call Swoop()<CR>
Shortcut swoop selection
      \ vmap <leader>ss :call SwoopSelection()<CR>

Shortcut swoop all open buffers
      \ nmap <leader>sS :call SwoopMulti()<CR>
Shortcut swoop selection in all open buffers
      \ vmap <leader>sS :call SwoopMultiSelection()<CR>
" sa        - ag
" -----------------------------------
" sg        - grep
" -----------------------------------
" sk        - ack
" -----------------------------------
" st        - pt
" -----------------------------------
" sw        - web
" -----------------------------------
" t         - toggles
" -----------------------------------

" Toggle spelling
"!function ToggleSpelling()
    "if &spelllang ==# 'en_us'
"endfunction

"nmap <leader> ts :call ToggleSpelling()<CR>

" T         - colorscheme toggles
" -------------------------------------------------

Shortcut switch between light and dark colorschemes
      \ nmap <leader>Ts :call ToggleScheme()<CR>

" w         - windows
" -------------------------------------------------
Shortcut focus left
      \ nmap <leader>wh <C-w>h
Shortcut focus down
      \ nmap <leader>wj <C-w>j
Shortcut focus up
      \ nmap <leader>wk <C-w>k
Shortcut focus right
      \ nmap <leader>wl <C-w>l

Shortcut move split to left
      \ nmap <leader>wH <C-w>H
Shortcut move split to down
      \ nmap <leader>wJ <C-w>J
Shortcut move split to up
      \ nmap <leader>wK <C-w>K
Shortcut move split to right
      \ nmap <leader>wL <C-w>L
"  wt       - tabs
" -------------------------------------------------
" tab controls
Shortcut open current split in new tab
      \ nmap <leader>wts :tab split<CR>
Shortcut close current tab
      \ nmap <leader>wtc :tabc<CR>
Shortcut go to next tab
      \ nmap <leader>wtt gt
Shortcut go to previous tab
      \ nmap <leader>wtT gT
