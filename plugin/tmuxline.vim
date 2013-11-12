
function! s:complete_themes_presets(A,L,P)
    let pre   = a:L[0 : a:P-1]
    let theme = matchstr(pre, '\S*\s\+\zs\(\S\+\)\ze\s')

    let dir   = theme ==# '' ? 'autoload/tmuxline/themes/' : 'autoload/tmuxline/presets/'
    let files = split(globpath(&rtp, dir . a:A . '*'), "\n")

    return map(files, 'fnamemodify(v:val, ":t:r")')
endfunction

command! -nargs=* -bar -complete=customlist,<sid>complete_themes_presets Tmuxline call tmuxline#set_statusbar(<f-args>)
command! -nargs=1 -bang -complete=file -bar TmuxlineSnapshot call tmuxline#snapshot(<f-args>, strlen("<bang>"))

