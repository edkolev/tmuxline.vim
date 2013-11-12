function! tmuxline#themes#airline#get() abort
    let colors = {}

    let mode = 'normal'
    let n1 = g:airline#themes#{g:airline_theme}#palette[mode]

    let colors.a = s:airline_to_tmuxline(n1.airline_a)
    let colors.b = s:airline_to_tmuxline(n1.airline_b)
    let colors.c = s:airline_to_tmuxline(n1.airline_c)

    let colors.x = deepcopy(colors.c)
    let colors.y = deepcopy(colors.b)
    let colors.z = deepcopy(colors.a)

    let colors.bg = deepcopy(colors.c)
    let colors.win = deepcopy(colors.a)
    let colors.cwin = deepcopy(colors.b)
    return colors
endfunc

fun! s:airline_to_tmuxline(air)
    return [ 'colour' . a:air[2], 'colour' . a:air[3] ]
endfun
