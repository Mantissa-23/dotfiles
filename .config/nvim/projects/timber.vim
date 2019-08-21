" Used for development of godot-dualgen in the timber project
function! s:body()
  let projroot = IsProject('timber', ['.git'])
  if type(projroot) == v:t_string
    let includes = ['', '/godot/', '/godot/platform/x11/', '/godot-dualgen/lib/armadillo/include/', '/godot-dualgen/lib/libfive/libfive/include/', '/godot-dualgen/lib/eigen/']
    let opts = '-std=c++11 -Wall' . join(includes, ' -I ' . projroot)
    let b:ale_cpp_clang_options = opts
    let b:ale_cpp_gcc_options = opts
    let b:ale_fixers = ['gcc']
    let b:ale_linters = ['gcc']
    setlocal noexpandtab tabstop=2 shiftwidth=2 autoindent
  endif
endfunction

aug timber
  au!
  au BufRead,BufNewFile *.cpp,*.h call s:body()
aug END
