
function! tmuxline#themes#vim_statusline_1#get() abort
  let colors = tmuxline#util#get_colors_from_vim_statusline()
  return {
        \ 'a'    : colors.statusline_nc,
        \ 'b'    : colors.statusline_nc,
        \ 'c'    : colors.statusline_nc,
        \ 'x'    : colors.statusline_nc,
        \ 'y'    : colors.statusline_nc,
        \ 'z'    : colors.statusline_nc,
        \ 'bg'   : colors.statusline_nc,
        \ 'win'  : colors.statusline_nc,
        \ 'cwin' : colors.statusline,
        \ 'pane' : [ colors.statusline_nc[1] ],
        \ 'cpane': [ colors.statusline[1] ]}
endfunc
