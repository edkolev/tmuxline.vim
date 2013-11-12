fun! tmuxline#presets#default#get()
    let bar = tmuxline#new()

    call bar.left.add('a', '#S')
    " call bar.left.add_left_alt_sep()
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

    " call bar.win.add('win', '#I')
    " call bar.win.add_left_alt_sep()
    call bar.win.add('win', '#W')

    call bar.cwin.add_left_sep()
    " call bar.cwin.add('cwin', '#I')
    " call bar.cwin.add_left_alt_sep()
    call bar.cwin.add('cwin', '#W')
    call bar.cwin.add_left_sep()

    let bar.justify = 'centre'

    return bar
endfun

" defaults:
" status-right "#22T" %H:%M %d-%b-%y
" status-left [#S]
" winwows 1:bash-
"
" return {
"     \ 'left'           : [ '#S',  '#W', '#H' ],
"     \ 'right'          : [ ['%b', '%d', '%Y'] ,'%R' ,'#H' ],
"     \ 'window'         : [ '#I', '#W#F' ],
"     \ 'window_current' : [ '#I', '#W#F' ]}
" }

