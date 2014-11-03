fun! tmuxline#presets#tmux#get()

  " tmux defaults:
  " status-right "#22T" %H:%M %d-%b-%y
  " status-left [#S]
  " windows #I:#W#F

  let bar = tmuxline#util#create_line_from_hash({
        \ 'a': '[#S]',
        \ 'win': '#I:#W#F',
        \ 'cwin': '#I:#W#F',
        \ 'z': '"#22T" %H:%M %d-%b-%y',
        \ 'options': {
        \'status-justify': 'left'}
        \})

  return bar
endfun
