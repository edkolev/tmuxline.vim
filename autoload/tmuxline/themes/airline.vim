
function! tmuxline#themes#airline#get() abort
    let mode = 'normal'
    let mode_palette = g:airline#themes#{g:airline_theme}#palette[mode]
    return tmuxline#util#create_theme_from_airline(mode_palette)
endfunc
