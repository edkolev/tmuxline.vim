fun! tmuxline#presets#minimal#get()

  " tmux defaults:
  " status-right %R
  " status-left #S
  " windows #I #W

  return tmuxline#util#create_line_from_hash({
        \ 'a': '#S',
        \ 'win': '#I #W',
        \ 'cwin': '#I #W',
        \ 'z': '%R',
        \ 'options': {
        \'status-justify': 'left'}
        \})

  return bar
endfun
