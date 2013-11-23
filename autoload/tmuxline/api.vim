" The MIT License (MIT)
"
" Copyright (c) 2013 Evgeni Kolev

fun! tmuxline#api#set_theme(theme)
  return tmuxline#set_theme(a:theme)
endfun

fun! tmuxline#api#create_theme_from_airline(mode_palette)
  return tmuxline#util#create_theme_from_airline(a:mode_palette)
endfun

fun! tmuxline#api#snapshot(file)
  return tmuxline#snapshot(a:file, 1)
endfun
