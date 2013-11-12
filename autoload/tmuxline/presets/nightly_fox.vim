" The MIT License (MIT)
"
" Copyright (c) 2013 Evgeni Kolev


" inspired by http://paulrouget.com/e/myconf/

fun! tmuxline#presets#nightly_fox#get()
    let bar = tmuxline#new()

    call bar.right.add('z', '%H:%M')

    call bar.win.add('win.dim', '#I')
    call bar.win.add('win', '#W')

    call bar.cwin.add_left_sep()
    call bar.cwin.add('cwin', '#W')
    call bar.cwin.add_left_sep()

    let bar.cwin_justify = 'left'

    return bar
endfun
