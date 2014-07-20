
function! tmuxline#themes#vim_statusline_3#get() abort
  let colors = tmuxline#util#get_colors_from_vim_statusline()
  return {
        \ 'a'    : colors.reversed_statusline ,
        \ 'b'    : colors.statusline ,
        \ 'c'    : colors.statusline_nc ,
        \ 'x'    : colors.statusline_nc ,
        \ 'y'    : colors.statusline ,
        \ 'z'    : colors.reversed_statusline ,
        \ 'bg'   : colors.statusline_nc ,
        \ 'win'  : colors.statusline_nc ,
        \ 'cwin' : colors.statusline ,
        \ 'pane' : colors.reversed_statusline_nc ,
        \ 'cpane': colors.reversed_statusline }
endfunc
