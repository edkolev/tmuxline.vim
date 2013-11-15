
fun! tmuxline#presets#full#get()
  return tmuxline#util#create_line_from_hash({
        \ 'a': '#S',
        \ 'b': '#F',
        \ 'c': '#W',
        \ 'win': ['#I', '#W'],
        \ 'cwin': ['#I', '#W'],
        \ 'x': '%a',
        \ 'y': ['%b %d', '%R'],
        \ 'z': '#H'})

    return bar
endfun
