"                           Custom Functions
" ----------------------------------------------------------------------------
" COLORSCHEMES

" Functions to toggle colorscheme between dark and light schemes, for quick
" switching between dark and light environments.

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

" JOURNALING

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

" ENTER-ENTER
function! EnterEnter()
	if getline(".") =~ '^\s*\(//\|#\|"\)\s*$'
		return "\<C-u>"
	else
		return "\<CR>"
	endif
endfunction

" !function ToggleSpelling()
"     if &spelllang ==# 'en_us'
" endfunction
