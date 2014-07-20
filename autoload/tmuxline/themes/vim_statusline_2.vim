
function! tmuxline#themes#vim_statusline_2#get() abort
  let colors = tmuxline#util#get_colors_from_vim_statusline()
  return {
        \ 'a'    : colors.statusline,
        \ 'b'    : colors.statusline,
        \ 'c'    : colors.statusline,
        \ 'x'    : colors.statusline,
        \ 'y'    : colors.statusline,
        \ 'z'    : colors.statusline,
        \ 'bg'   : colors.statusline,
        \ 'win'  : colors.statusline,
        \ 'cwin' : colors.statusline_nc,
        \ 'pane' : [ colors.statusline_nc[1] ],
        \ 'cpane': [ colors.statusline[1] ]}
endfunc
