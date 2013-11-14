
fun! tmuxline#presets#full#get()
  return tmuxline#util#create_line_from_hash({
        \ 'a': '#S',
        \ 'b': '#F',
        \ 'win': ['#I', '#W'],
        \ 'cwin': ['#I', '#W'],
        \ 'x': '#W',
        \ 'y': ['%b %d', '%R'],
        \ 'z': '#H'})

    let bar = tmuxline#new()

    call bar.left.add('a', '#S')
    call bar.left.add_left_sep()
    call bar.left.add('b', '#F')
    call bar.left.add_left_sep()

    call bar.right.add_right_sep()
    call bar.right.add('x', '#W')
    call bar.right.add_right_sep()
    call bar.right.add('y', '%b %d')
    call bar.right.add_right_alt_sep()
    call bar.right.add('y', '%R')
    call bar.right.add_right_sep()
    call bar.right.add('z', '#H')

    call bar.win.add_left_sep()
    call bar.win.add('win', '#I')
    call bar.win.add_left_alt_sep()
    call bar.win.add('win', '#W')
    call bar.win.add_left_sep()

    call bar.cwin.add_left_sep()
    call bar.cwin.add('cwin', '#I')
    call bar.cwin.add_left_alt_sep()
    call bar.cwin.add('cwin', '#W')
    call bar.cwin.add_left_sep()

    return bar
endfun
