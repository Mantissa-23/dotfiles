" Used for development of godot-dualgen in the timber project
function! s:body()
  let projroot = IsProject('timber', ['.git'])
  if type(projroot) == v:t_string
    let includes = ['/godot/', '/godot/platform/x11/', '/godot-dualgen/lib/armadillo/include/', '/godot-dualgen/lib/libtorch/include/torch/csrc/api/include/']
    let libraries = ['openblas', 'lapack', 'libtorch']
    let opts = ['-std=c++11', '-Wall']
    for s in includes
      call add(opts, '-I ' . projroot . s)
    endfor
    call add(opts, '-L ' . projroot . '/godot-dualgen/lib/libtorch/lib')
    for s in libraries
      call add(opts, '-l ' . projroot . s)
    endfor
    let b:ale_cpp_clang_options = join(opts, ' ')
    let b:ale_cpp_gcc_options = join(opts, ' ')
    let b:ale_fixers = ['gcc']
    let b:ale_linters = ['gcc']
    let b:ycm_cpp_flags = opts
    setlocal noexpandtab tabstop=2 shiftwidth=2 autoindent
  endif
  " echom "hi!"
endfunction

aug timber
  au!
  au BufEnter *.cpp,*.h call s:body()
aug END
