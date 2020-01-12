
fun! tmuxline#themes#airline_tabline#get() abort
  if !has_key(g:, 'airline_theme')
    throw "tmuxline: Can't load theme from airline, g:airline_theme isn't defined. Is airline loaded?"
  endif
  if !has_key(g:, 'airline#themes#' . g:airline_theme . '#palette')
    throw "tmuxline: Can't load theme from airline, 'g:airline#themes#" . g:airline_theme . "#palette' isn't defined. Is airline loaded?"
  endif

  let l:mode = 'normal'
  let l:mode_palette = g:airline#themes#{g:airline_theme}#palette[l:mode]
  let l:theme = tmuxline#util#create_theme_from_airline(l:mode_palette)
  let l:theme.cwin = l:mode_palette.airline_a[2:4]
  return l:theme
endfun
