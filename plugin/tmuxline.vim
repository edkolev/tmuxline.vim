" The MIT License (MIT)
"
" Copyright (c) 2013-2014 Evgeni Kolev

if !strlen($TMUX) || !executable('tmux')
  command! -nargs=* Tmuxline echoerr ":Tmuxline should be executed in a tmux sesssion"
  finish
endif

command! -nargs=* -bar -complete=customlist,tmuxline#command_completion#complete_themes_and_presets Tmuxline call tmuxline#set_statusline(<f-args>)
command! -nargs=1 -bang -complete=file -bar TmuxlineSnapshot call tmuxline#snapshot(<f-args>, strlen("<bang>"))

