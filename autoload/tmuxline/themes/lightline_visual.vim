
function! tmuxline#themes#lightline_visual#get() abort
  if !exists('*lightline#palette')
    throw "tmuxline: Can't load theme from lightline, function lightline#palette() doesn't exist. Is latest lightline loaded?"
  endif

  let palette = lightline#palette()
  let palette_for_visual = extend( deepcopy(palette.normal), palette.visual )

  return tmuxline#util#create_theme_from_lightline(palette_for_visual)
endfunc
