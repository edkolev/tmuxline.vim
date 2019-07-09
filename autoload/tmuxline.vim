" The MIT License (MIT)
"
" Copyright (c) 2013-2014 Evgeni Kolev

let s:default_theme = 'powerline'
let s:default_preset = 'powerline'
let s:default_status_justify = 'centre'

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
fun! tmuxline#new()
  let bar = {}
  let bar.left = tmuxline#builder#new()
  let bar.right = tmuxline#builder#new()
  let bar.win = tmuxline#builder#new()
  let bar.cwin = tmuxline#builder#new()
  let bar.options = {}
  let bar.win_options = {}
  return bar
endfun

fun! tmuxline#set_statusline(...) abort
  let theme = get(a:, 1, get(g:, 'tmuxline_theme', s:default_theme))
  let preset = get(a:, 2, get(g:, 'tmuxline_preset', s:default_preset))

  try
    call tmuxline#set_statusline_theme_and_preset(theme, preset)
  catch /^tmuxline:/
    echohl ErrorMsg | echomsg v:exception | echohl None
  endtry
endfun

fun! tmuxline#set_statusline_simple(...) abort
  let colors = tmuxline#util#get_colors_from_vim_statusline()

  let variant = empty(a:000) ? '1' : a:1

  if (variant == 1)
    let [fg, bg, attr]                = colors.statusline_nc
    let [curr_fg, curr_bg, curr_attr] = colors.statusline
  elseif (variant == 2)
    let [fg, bg, attr]                = colors.statusline
    let [curr_fg, curr_bg, curr_attr] = colors.statusline_nc
  elseif (variant == 3)
    let fg = colors.statusline[0]
    let bg = colors.statusline[1]
    let attr = ''
    let curr_fg = colors.statusline[0]
    let curr_bg = colors.statusline[1]
    let curr_attr = 'reverse'
  elseif (variant == 4)
    let [fg, bg, attr]                = colors.statusline_nc
    let [curr_fg, curr_bg, curr_attr] = colors.statusline_nc
  else
    echohl ErrorMsg | echomsg "tmuxline: invalid variant" | echohl None
  endif

  let attr = len(attr) ? ',' . attr : attr
  let curr_attr = len(curr_attr) ? ',' . curr_attr : curr_attr

  let line_settings = [
        \ 'set -g status-style fg=colour' . fg . ',bg=colour' . bg . attr,
        \ 'set -g window-status-current-style fg=colour' . curr_fg . ',bg=colour' . curr_bg . curr_attr]

  try
    call tmuxline#apply(line_settings)
  catch /^tmuxline:/
    echohl ErrorMsg | echomsg v:exception | echohl None
  endtry
endfun

fun! tmuxline#set_statusline_theme_and_preset(theme, preset)
  let line = tmuxline#load_line(a:preset)
  let colors = tmuxline#load_colors(a:theme)
  let separators = tmuxline#get_separators()

  let line_settings = tmuxline#get_line_settings(line, colors, separators)

  call tmuxline#apply(line_settings)
endfun

fun! tmuxline#load_colors(source) abort
  if type(a:source) == type("")
    let colors = tmuxline#util#load_colors_from_theme(a:source)
  elseif type(a:source) == type({})
    let colors = tmuxline#util#load_colors_from_hash(a:source)
  else
    throw "Invalid type of g:tmuxline_preset"
  endif
  return colors
endfun

fun! tmuxline#load_line(source) abort
  if type(a:source) == type("")
    let builder = tmuxline#util#load_line_from_preset(a:source)
  elseif type(a:source) == type({})
    let builder = tmuxline#util#create_line_from_hash(a:source)
  else
    throw "Invalid type of g:tmuxline_preset"
  endif
  return builder
endfun

fun! tmuxline#apply(line_settings) abort
  let temp_file = tempname()
  try
    call writefile(a:line_settings, temp_file)
    call system("tmux source " . tmuxline#util#wrap_in_quotes(temp_file))
  finally
    call delete(temp_file)
  endtry

  let s:snapshot = a:line_settings
endfun

fun! tmuxline#snapshot(file, overwrite) abort
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
endfun

fun! tmuxline#get_line_settings(line, theme, separators) abort
  let statusline_config = tmuxline#get_statusline_config(a:line, a:theme, a:separators)
  let general_config = tmuxline#get_global_config(a:line, a:theme)
  return general_config + statusline_config
endfun

fun! tmuxline#get_statusline_config(line, theme, separators)
  let left = a:line.left.build(a:theme, a:separators)
  let right = a:line.right.build(a:theme, a:separators)
  let win = a:line.win.build(a:theme, a:separators)
  let cwin = a:line.cwin.build(a:theme, a:separators)

  return [
        \ 'set -g status-left ' . tmuxline#util#wrap_in_quotes(left),
        \ 'set -g status-right ' . tmuxline#util#wrap_in_quotes(right),
        \ 'setw -g window-status-format ' . tmuxline#util#wrap_in_quotes(win),
        \ 'setw -g window-status-current-format ' . tmuxline#util#wrap_in_quotes(cwin)]
endfun

fun! tmuxline#get_global_config(line, theme)
  let bg                 = tmuxline#util#normalize_color(a:theme.bg[1])
  let message_bg         = tmuxline#util#normalize_color(a:theme.cwin[1])
  let message_fg         = tmuxline#util#normalize_color(a:theme.cwin[0])
  let pane_border        = has_key(a:theme, 'pane',) ? tmuxline#util#normalize_color(a:theme.pane[0]) : tmuxline#util#normalize_color(a:theme.b[1])
  let pane_active_border = has_key(a:theme, 'cpane',) ? tmuxline#util#normalize_color(a:theme.cpane[0]) : tmuxline#util#normalize_color(a:theme.a[1])
  let status_justify     = get(g:, 'tmuxline_status_justify', s:default_status_justify)

  let window = tmuxline#util#get_color_definition_from_theme('win', a:theme)
  let window_fg = window[0]
  let window_bg = window[1]
  let window_attr = len(window[2]) ? window[2] : 'none'

  let window_activity = tmuxline#util#get_color_definition_from_theme('win.activity', a:theme)
  if !has_key(a:theme, 'win.activity') |
    let window_activity[2] = 'underscore'
  endif
  let window_activity_fg = window_activity[0]
  let window_activity_bg = window_activity[1]
  let window_activity_attr = len(window_activity[2]) ? window_activity[2] : 'none'

  let misc_options = {
        \ 'status-style'                : printf('none,bg=%s', bg),
        \ 'message-style'               : printf('fg=%s,bg=%s', message_fg, message_bg),
        \ 'message-command-style'       : printf('fg=%s,bg=%s', message_fg, message_bg),
        \ 'pane-border-style'           : printf('fg=%s', pane_border),
        \ 'pane-active-border-style'    : printf('fg=%s', pane_active_border),
        \ 'status-justify'              : status_justify,
        \ 'status-left-length'          : 100,
        \ 'status-right-length'         : 100,
        \ 'status'                      : 'on',
        \ 'status-right-style'          : 'none',
        \ 'status-left-style'           : 'none'}
  let win_options = {
        \ 'window-status-style'         : printf('%s,fg=%s,bg=%s', window_attr, window_fg, window_bg),
        \ 'window-status-activity-style': printf('%s,fg=%s,bg=%s', window_activity_attr, window_activity_fg, window_activity_bg),
        \ 'window-status-separator'     : ''}

  call extend(misc_options, a:line.options)
  call extend(win_options, a:line.win_options)

  let global_config = []
  for [tmux_option, value] in items(misc_options)
    let global_config += [ 'set -g ' . tmux_option . ' ' . tmuxline#util#wrap_in_quotes(value) ]
  endfor
  for [tmux_option, value] in items(win_options)
    let global_config += [ 'setw -g ' . tmux_option . ' ' . tmuxline#util#wrap_in_quotes(value) ]
  endfor

  return global_config
endfun

fun! tmuxline#set_theme(theme) abort
  let preset = get(g:, 'tmuxline_preset', s:default_preset)

  let line = tmuxline#load_line(preset)
  let separators = tmuxline#get_separators()
  let line_settings = tmuxline#get_line_settings(line, a:theme, separators)

  call tmuxline#apply(line_settings)
endfun

