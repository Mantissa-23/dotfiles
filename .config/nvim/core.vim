" Custom keymappings
" ------------------

" Leader controls
let mapleader=" "

" Make tab and window navigation more sensible
" Functionality replaced with plugin
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

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

" Toggle spelling
"!function ToggleSpelling()
    "if &spelllang ==# 'en_us'
"endfunction

"nmap <leader> ss :call ToggleSpelling()<CR>

" Aesthetics
" ----------

colorscheme solarized

function! DarkScheme()
    " colorscheme solarized
    set background=dark
endfunction

function! LightScheme()
    " colorscheme solarized
    set background=light
endfunction

" Toggles colorscheme between dark and light schemes, for quick switching
" between dark and light environments. Bound to <leader>cs under leader
" bindings.
function! ToggleScheme()
    if &background ==# 'light'
        call DarkScheme()
    elseif &background ==# 'dark'
        call LightScheme()
    endif
endfunction

" Default to light scheme
call LightScheme()

" Quickswitch colorscheme
nmap <leader>cs :call ToggleScheme()<CR>

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

" Only use out-of-source build if no in-source build is detected.
if globpath('.','Makefile') == ''
    autocmd BufNewFile,BufRead *.cpp,*.c call g:BuildInSubDir("/build")
endif
