" The MIT License (MIT)
"
" Copyright (c) 2013 Evgeni Kolev

let s:default_theme = 'powerline_like'
let s:default_preset = 'powerline_like'

let s:powerline_separators = {
    \ 'left' : '',
    \ 'left_alt': '',
    \ 'right' : '',
    \ 'right_alt' : '',
    \ 'space' : ' '}

let s:simple_separators = {
    \ 'left' : '',
    \ 'left_alt': '|',
    \ 'right' : '',
    \ 'right_alt' : '|',
    \ 'space' : ' '}

let s:snapshot = []

fun! tmuxline#get_separators()
    let use_powerline_separators = get(g:, 'tmuxline_powerline_separators', 1)
    let separators = use_powerline_separators ? s:powerline_separators : s:simple_separators

    return extend(separators, get(g:, 'tmuxline_separators', {}))
endfun

" wrapper around four builders, tmux settings
"
" TODO
" set -g status on
" set -g status-utf8 on
"
fun! tmuxline#new()
    let bar = {}
    let bar.left = tmuxline#builder#new()
    let bar.right = tmuxline#builder#new()
    let bar.win = tmuxline#builder#new()
    let bar.cwin = tmuxline#builder#new()
    let bar.cwin_justify = 'centre'
    let bar.left_length = 80
    let bar.right_length = 80
    return bar
endfun

fun! tmuxline#set_statusbar(...) abort
    let theme_name = get(a:, 1, get(g:, 'tmuxline_theme', s:default_theme))
    let preset = get(a:, 2, get(g:, 'tmuxline_preset', s:default_preset))

    " TODO builder is not a builder, but 4 builders
    " TODO rename load_bar to ...line
    let builder = tmuxline#load_bar(preset)
    let colors = tmuxline#load_colors_from_theme(theme_name)
    let separators = tmuxline#get_separators()
    let line_settings = tmuxline#get_line_settings(builder, colors, separators)

    call tmuxline#apply(line_settings)
endfun

fun! tmuxline#load_colors_from_theme(theme_name) abort
    try
      let colors = tmuxline#themes#{a:theme_name}#get()
    catch
      throw "tmuxline error: invalid theme \"" . a:theme_name . "\""
    endtry
    return colors
endfun

" TODO put in util
fun! tmuxline#load_bar(source) abort
    if type(a:source) == type("")
      let builder = tmuxline#load_builder_from_preset(a:source)
    elseif type(a:source) == type({})
      let builder = tmuxline#util#create_bar_from_hash(a:source)
    else
      throw "Invalid type of g:tmuxline_preset"
    endif
    return builder
endfun

" TODO rename load_bar_from__*  load_line?
fun! tmuxline#load_builder_from_preset(preset_name) abort
    try
      let line = tmuxline#presets#{a:preset_name}#get()
    catch
      throw "tmuxline error: invalid preset \"" . a:preset_name . "\""
    endtry
    return line
endfun

fun! tmuxline#apply(line_settings) abort
    for setting in a:line_settings
        call system("tmux " . setting)
    endfor

    let s:snapshot = a:line_settings
endfun

fun! tmuxline#snapshot(file, overwrite)
  let file = fnamemodify(a:file, ":p")
  let dir = fnamemodify(file, ':h')


  if (len(s:snapshot) == 0)
    echohl ErrorMsg | echomsg ":Tmuxline should be executed before :TmuxlineSnapshot" | echohl None
    return
  endif

  if empty(file)
    throw "Bad file name: \"" . file . "\""
  elseif (filewritable(dir) != 2)
    throw "Cannot write to directory \"" . dir . "\""
  elseif (glob(file) || filereadable(file)) && !a:overwrite
    echohl ErrorMsg | echomsg "File exists (add ! to override)" | echohl None
    return
  endif

  let lines = []
  let lines += [ '# This tmux statusbar config was created by tmuxline.vim']
  let lines += [ '# on ' . strftime("%a, %d %b %Y") ]
  let lines += [ '' ]
  let lines += s:snapshot

  call writefile(lines, file)
  echomsg "Snapshot created in \"" . file ."\""
endfun

fun! tmuxline#get_line_settings(builder, theme, separators) abort

    let left = a:builder.left.build(a:theme, a:separators)
    let right = a:builder.right.build(a:theme, a:separators)
    let win = a:builder.win.build(a:theme, a:separators)
    let cwin = a:builder.cwin.build(a:theme, a:separators)
    let justify = a:builder.cwin_justify
    let left_length = a:builder.left_length
    let right_length = a:builder.right_length
    let bg = tmuxline#util#normalize_color(a:theme.bg[1])

    " TODO 50 lenght
    " TODO window-status-separator???
    return [
        \ 'set -g status-left ' . shellescape(left),
        \ 'set -g status-right ' . shellescape(right),
        \ 'setw -g window-status-format ' .shellescape(win),
        \ 'setw -g window-status-current-format ' . shellescape(cwin),
        \ 'set -g status-left-length ' . shellescape(left_length),
        \ 'set -g status-right-length ' . shellescape(right_length),
        \ 'set -g status-justify ' . shellescape(justify),
        \ 'set -g status-bg ' . shellescape(bg),
        \ 'setw -g window-status-separator ""']
    " TODO window-status-sep
endfun

