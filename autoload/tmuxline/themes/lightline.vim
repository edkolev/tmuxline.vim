
function! tmuxline#themes#lightline#get() abort
  let palette = lightline#palette()
  return tmuxline#util#create_theme_from_lightline(palette.normal)
endfunc
