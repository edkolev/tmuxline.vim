" The MIT License (MIT)
"
" Copyright (c) 2013-2014 Evgeni Kolev

let s:builder = {}

let s:TEXT = 1
let s:LEFT_ALT_SEP = 2
let s:RIGHT_ALT_SEP = 3
let s:LEFT_SEP = 4
let s:RIGHT_SEP = 5

let s:SEP_ATTRIBUTES = 'nobold,nounderscore,noitalics'

fun! s:builder.add(style, text)
    call add(self._contents, [s:TEXT ,a:style, a:text])
endfun

fun! s:builder.add_left_alt_sep()
    call add(self._contents, [s:LEFT_ALT_SEP, '', ''])
endfun

fun! s:builder.add_left_sep()
    call add(self._contents, [s:LEFT_SEP, '', ''])
endfun

fun! s:builder.add_right_alt_sep()
    call add(self._contents, [s:RIGHT_ALT_SEP, '', ''])
endfun

fun! s:builder.add_right_sep()
    call add(self._contents, [s:RIGHT_SEP, '', ''])
endfun

fun! s:builder.build(theme, separators) abort
    let line = ''
    let pending_separator = ''
    let last_style = 'bg'
    let space = a:separators.space
    for [type, style, text] in self._contents
        if pending_separator
            let line .= s:make_separator(last_style, style, pending_separator, a:separators, a:theme)
            let pending_separator = ''
        endif
        if type == s:TEXT
            let preceeding_space = matchend(line, ' $') > 0 ? '' : space
            if last_style == style
                let line .= preceeding_space . text . space
            elseif len(text) > 0
                let color = tmuxline#util#get_color_from_theme(style, a:theme)
                let line .= color . preceeding_space . text . space
            endif
        elseif type == s:LEFT_ALT_SEP
            let line .= a:separators.left_alt
        elseif type == s:RIGHT_ALT_SEP
            let line .= a:separators.right_alt
        elseif type == s:RIGHT_SEP || type == s:LEFT_SEP
            let pending_separator = type
        endif

        let last_style = len(style) ? style : last_style
    endfor

    if pending_separator
        let line .= s:make_separator(last_style, 'bg', pending_separator, a:separators, a:theme)
    endif
    return line
endfun

fun! s:make_separator(from_style, to_style, separator_type, separators, theme) abort
    let from_color = tmuxline#util#get_color_definition_from_theme(a:from_style, a:theme)
    let to_color = tmuxline#util#get_color_definition_from_theme(a:to_style, a:theme)
    let [fg, bg] = a:separator_type == s:LEFT_SEP ? [ from_color[1], to_color[1] ] : [ to_color[1], from_color[1] ]
    let separator = a:separator_type == s:LEFT_SEP ? a:separators.left : a:separators.right
    return tmuxline#util#tmux_color_attr(fg, bg, s:SEP_ATTRIBUTES) . separator
endfun

fun! tmuxline#builder#new()
    let builder = copy(s:builder)
    let builder._contents = []
    return builder
endfun

" vim: et ts=4 sts=4 sw=4
