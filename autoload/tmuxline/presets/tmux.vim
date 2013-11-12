" TODO clean up
" fun! tmuxline#presets#tmux#get()
"   return tmuxline#util#create_bar_from_hash({
"         \ 'a': '[#S]',
"         \ 'win': '#I:#W#F',
"         \ 'cwin': '#I:#W#F',
"         \ 'z': '"#22T" %H:%M %d-%b-%y',
"         \ 'cwin_justify': 'left'})
" endfun

fun! tmuxline#presets#tmux#get()
  return tmuxline#util#create_bar_from_hash({
        \ 'a': '[#S]',
        \ 'win': '#I:#W#F',
        \ 'cwin': '#I:#W#F',
        \ 'z': '"#22T" %H:%M %d-%b-%y',
        \ 'cwin_justify': 'left'})
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
"
" { 'a': '[#S]', 'win': '#I:#WWF', 'cwin': '#I:#WWF', 'z': '"#22T" %H:%M %d-%b-%y'} }
