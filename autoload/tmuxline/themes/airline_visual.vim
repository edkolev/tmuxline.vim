
fun! tmuxline#themes#airline_visual#get() abort
  if !has_key(g:, 'airline_theme')
    throw "tmuxline: Can't load theme from airline, g:airline_theme isn't defined. Is airline loaded?"
  endif
  if !has_key(g:, 'airline#themes#' . g:airline_theme . '#palette')
    throw "tmuxline: Can't load theme from airline, 'g:airline#themes#" . g:airline_theme . "#palette' isn't defined. Is airline loaded?"
  endif

  let mode = 'visual'
  let mode_palette = g:airline#themes#{g:airline_theme}#palette[mode]
  return tmuxline#util#create_theme_from_airline(mode_palette)
endfun
