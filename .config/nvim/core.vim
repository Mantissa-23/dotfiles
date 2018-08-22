"                               Aesthetics
" ----------------------------------------------------------------------------

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

" Safeguarded syntax enable
if !exists("g:syntax_on")
    syntax enable
endif

" Generic Tab Settings
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent

" Enable line number display, always
set number
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

"                           Custom Functions
" ----------------------------------------------------------------------------

function! JFilename()
    let journaldir = '~/Docs/Org/Journal/'
    let name = strftime('%Y%m%d.org')
    return journaldir . name
endfunction

function! JNewEntry()
    let filename = JFilename()

    "if bufwinnr(filename) == -1
    execute ":vsp" filename
    "else
        "execute ":sbuffer" filename
    "endif
    
    " If new file unopened in buffer, add date header
    if empty(glob(filename)) && bufwinnr(filename) == -1 
        execute "normal! A* " . strftime('%A, %m/%d/%y')
    endif

    execute "normal! Go** " . strftime('%H:%M')
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
    :tnoremap fd <Esc>
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

" Leader Keymappings
" ----------------------------------------------------------------------------

" ALL HAIL OUR GLORIOUS ETERNAL LEADER, THE SPACEBAR, PRAISE BE TO HIM
let mapleader=" "

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
" New journal entry
nnoremap <leader>ajj :call JNewEntry()<CR> 
" View current journal entry
nnoremap <leader>avj :call JNewEntry()<CR>
" as        - Shells/Terminals
" -----------------------------------
" b         - Buffers
" -----------------------------------
" Close current buffer and the window it's in
nmap <leader>bd :bdelete<CR> 
nmap <leader>bd! :bdelete!<CR> 

" c         - Comments
" -----------------------------------
" C         - Compile
" -----------------------------------

" Map nm to full-project make
nmap <leader>Cnm :Neomake!<CR>

" e         - Errors/Linting/Language Diagnostics
" -----------------------------------
" f         - Files
" -----------------------------------

" NERDTree controls
nmap <leader>ft :NERDTreeToggle<CR>
nmap <leader>fnb :Bookmark 

" fe        - Edit configuration
" -----------------------------------

" Add control for quickly opening init.vim
nmap <leader>fei :vsp ~/.config/nvim/init.vim<CR>
" Add control for quickly opening core.vim
nmap <leader>fec :vsp ~/.config/nvim/core.vim<CR>

" Add control for quickly reloading current vimrc
nmap <leader>fer :so $MYVIMRC<CR>

" g         - Git/VCS
" -----------------------------------

" Fugitive controls
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gd :Gdiff<CR>

" h         - Help
" -----------------------------------
" i         - Insertion/Snippets
" -----------------------------------
" j         - Jump; File navigation
" -----------------------------------

" Open tagbar
nmap <leader>jt :TagbarToggle<CR>

" p         - Project
" -----------------------------------
" s         - Search
" -----------------------------------
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

" Quickswitch between dark and light colorschemes
nmap <leader>Tc :call ToggleScheme()<CR>

" w         - windows
" -------------------------------------------------
"  wt       - tabs

" tab controls
nmap <leader>wts :tab split<CR>
nmap <leader>wtc :tabc<CR>

