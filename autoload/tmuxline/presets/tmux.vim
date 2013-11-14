
fun! tmuxline#presets#tmux#get()
  let bar tmuxline#util#create_line_from_hash({
        \ 'a': '[#S]',
        \ 'win': '#I:#W#F',
        \ 'cwin': '#I:#W#F',
        \ 'z': '"#22T" %H:%M %d-%b-%y'})

  let bar.set['status-justify'] = 'left'

  return bar
endfun


" defaults:
" status-right "#22T" %H:%M %d-%b-%y
" status-left [#S]
" winwows #I:#W#F
