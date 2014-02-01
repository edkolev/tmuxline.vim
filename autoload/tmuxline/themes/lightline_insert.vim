function! tmuxline#themes#lightline_insert#get() abort
  if !exists('*lightline#palette')
    throw "tmuxline: Can't load theme from lightline, function lightline#palette() doesn't exist. Is latest lightline loaded?"
  endif

  let palette = lightline#palette()
  let pallete_for_insert = extend( deepcopy(palette.normal), palette.insert )

  return tmuxline#util#create_theme_from_lightline(pallete_for_insert)
endfunc
