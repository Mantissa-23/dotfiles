" Used for development of godot-dualgen in the timber project
function! s:body()
  let projroot = IsProject('timber', ['.git'])
  if type(projroot) == v:t_string
    let opts = '-std=c++11 -Wall -I ' . projroot . '/godot/ -I ' . projroot . '/godot/platform/x11/'
    let b:ale_cpp_clang_options = opts
    let b:ale_cpp_gcc_options = opts
    echo 'ALE configured for Godot development'
  endif
endfunction

aug timber
  au!
  au BufEnter *.cpp,*.h call s:body()
aug END
