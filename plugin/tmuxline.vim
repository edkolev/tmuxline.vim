" The MIT License (MIT)
"
" Copyright (c) 2013-2014 Evgeni Kolev

if !strlen($TMUX) || !executable('tmux')
  finish
endif

function! s:complete_themes(A,L,P)
    let files = split(globpath(&rtp, 'autoload/tmuxline/themes/' . a:A . '*'), "\n")
    return map(files, 'fnamemodify(v:val, ":t:r")')
endfunction

function! s:complete_presets(A,L,P)
    let files = split(globpath(&rtp, 'autoload/tmuxline/presets/' . a:A . '*'), "\n")
    return map(files, 'fnamemodify(v:val, ":t:r")')
endfunction

function! s:complete_themes_and_presets(A,L,P)
    let pre   = a:L[0 : a:P-1]

    let theme = matchstr(pre, '\S*\s\+\zs\(\S\+\)\ze\s')
    if theme ==# ''
      return s:complete_themes(a:A, a:L, a:P)
    endif

    let preset = matchstr(pre, '\S*\s\+\S\+\s\+\zs\(\S\+\)\ze\s')
    if preset ==# ''
      return s:complete_presets(a:A, a:L, a:P)
    endif

    return []
endfunction

command! -nargs=* -bar -complete=customlist,<sid>complete_themes_and_presets Tmuxline call tmuxline#set_statusline(<f-args>)
command! -nargs=1 -bang -complete=file -bar TmuxlineSnapshot call tmuxline#snapshot(<f-args>, strlen("<bang>"))

