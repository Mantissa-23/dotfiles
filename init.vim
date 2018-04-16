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
Plug 'neomake/neomake' " Syntax checker
"Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'

call plug#end()

" Custom keymappings
" ------------------

" Leader controls
let mapleader=" "

" Make tab and window navigation more sensible
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>h :tabp<CR>
nnoremap <leader>l :tabn<CR>

" Scroll through visible lines as opposed to numbered lines
nnoremap j gj
nnoremap k gk

" Use <Esc> to exit Terminal-mode for neovim's terminal emulator
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif


" Add control for quickly opening init.vim
nmap <leader>ev :vsp ~/.config/nvim/init.vim<CR>

" <leader> w writes file
nmap <leader>w :w<CR>

" tab controls
nmap <leader>ts :tab split<CR>
nmap <leader>tc :tabc<CR>

" Aesthetics
" ----------

colorscheme solarized

function! DarkScheme()
    set background=dark
    " colorscheme solarized
endfunction

function! LightScheme()
    set background=light
    " colorscheme solarized
endfunction

" Toggles colorscheme between dark and light schemes, for quick switching
" between dark and light environments. Bound to <leader>cs under leader
" bindings.
function! ToggleScheme()
    if &background ==# 'dark'
        call LightScheme()
    elseif &background ==# 'light'
        call DarkScheme()
    endif
endfunction

" Default to dark scheme
call LightScheme()

" Quickswitch colorscheme
nmap <leader>ts :call ToggleScheme()<CR>

" Color column 80, for code formatting
set colorcolumn=80

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

" Enable code folding
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


" Plugin configuration
" --------------------

" FILE SYSTEM & SCM

" Fugitive controls
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gd :Gdiff<CR>

" NERDTree controls
nmap <leader>nn :NERDTreeToggle<CR>
nmap <leader>nb :Bookmark 

" Tagbar controls
nmap <leader>tt :TagbarToggle<CR>

" BUILD, LINT, CHECK

" Neomake setup
let g:neomake_cpp_enabled_markers = ['gcc']
let g:neomake_c_enabled_markers = ['gcc']

" call neomake#configure#automake('nrwi', 500)

" Map nm to full-project make
nmap <leader>nm :Neomake!<CR>

" YCM Setup
let g:ycm_collect_identifiers_from_tags_files = 1

" Auto-Pair Setup
let g:AutoPairsFlyMode = 0

" AESTHETIC & INFORMATION

" Airline Customization
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensiosn#fugitiveline#enabled = 1

" Extra Configuration
" -------------------

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

autocmd BufNewFile,BufRead *.cpp,*.c call g:BuildInSubDir("/build")
