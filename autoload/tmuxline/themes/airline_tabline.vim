
fun! tmuxline#themes#airline_tabline#get() abort
  if !has_key(g:, 'airline_theme')
    throw "tmuxline: Can't load theme from airline, g:airline_theme isn't defined. Is airline loaded?"
  endif
  if !has_key(g:, 'airline#themes#' . g:airline_theme . '#palette')
    throw "tmuxline: Can't load theme from airline, 'g:airline#themes#" . g:airline_theme . "#palette' isn't defined. Is airline loaded?"
  endif

  let mode = 'normal'
  let mode_palette = g:airline#themes#{g:airline_theme}#palette[mode]
  let theme = tmuxline#util#create_theme_from_airline(mode_palette)
  let theme.cwin = mode_palette.airline_a[2:4]
  return theme
endfun
