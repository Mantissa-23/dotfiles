" OLD PLUGINS AND CONFIG
"
Plug 'jeffkreeftmeijer/vim-dim' " Enhanced default colorscheme
Plug 'morhetz/gruvbox' " Gruvbox, like solarized but warmer and more retro.

Plug 'neomake/neomake'
let g:neomake_cpp_enabled_markers = ['gcc']
let g:neomake_c_enabled_markers = ['gcc']
" Only use out-of-source build if no in-source build is detected.
if globpath('.','Makefile') == ''
    autocmd BufNewFile,BufRead *.cpp,*.c call g:BuildInSubDir("/build")
endif

Plug 'Valloric/YouCompleteMe'
let g:ycm_collect_identifiers_from_tags_files = 1

Plug 'ajh17/VimCompletesMe'
Plug 'ervandew/supertab' " Simple tab completion reliant on ale and ultisnips

" Tried to remap split movement, doesn't work with all terminals.
nnoremap <C-H> <C-w><S-h>
nnoremap <C-J> <C-w><S-j>
nnoremap <C-K> <C-w><S-k>
nnoremap <C-L> <C-w><S-l>

