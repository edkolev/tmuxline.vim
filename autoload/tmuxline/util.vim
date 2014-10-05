" The MIT License (MIT)
"
" Copyright (c) 2013-2014 Evgeni Kolev

let s:DEFAULT_COLOR = 'default'
let s:DEFAULT_COLOR_AND_ATTRIBUTES = '#[default]'
let s:FG = 0
let s:BG = 1
let s:ATTR = 2

fun! tmuxline#util#tmux_color_attr(fg, bg, attr)
  let fg = tmuxline#util#normalize_color(a:fg)
  let bg = tmuxline#util#normalize_color(a:bg)
  let color  =  'fg=' . fg
  let color .= ',bg=' . bg
  let color .= len( a:attr ) ? ',' : ''
  let color .= a:attr
  return '#[' . color . ']'
endfun

fun! tmuxline#util#normalize_color(color)
  " prepend 'colour' to numbers
  return a:color =~ '^\d\+$' ? "colour" . a:color : a:color
endfun

fun! tmuxline#util#normalize_color_definition(color_definition)
  let fg   = a:color_definition[s:FG]
  let bg   = a:color_definition[s:BG]
  let attr = get(a:color_definition, s:ATTR, '')

  return [ tmuxline#util#normalize_color(fg), tmuxline#util#normalize_color(bg), attr ]
endfun

fun! tmuxline#util#wrap_in_quotes(text)
  return '"' . escape(a:text, '"') . '"'
endfun

fun! tmuxline#util#get_color_definition_from_theme(color_name, theme)
  if has_key(a:theme, a:color_name)
    let color_definition = a:theme[a:color_name]
  else
    let downgraded_color_name = substitute(a:color_name, '\..*', '', '')
    if !has_key(a:theme, downgraded_color_name)
      throw "tmuxline: Color definition '" . a:color_name . "' not found in theme"
    else
      let color_definition = a:theme[downgraded_color_name]
    endif
  endif

  return tmuxline#util#normalize_color_definition(color_definition)
endfun

fun! tmuxline#util#get_color_from_theme(color_name, theme) abort
  if a:color_name ==# s:DEFAULT_COLOR
    return s:DEFAULT_COLOR_AND_ATTRIBUTES
  endif

  let color_definition = tmuxline#util#get_color_definition_from_theme(a:color_name, a:theme)
  let [fg, bg, attr] = color_definition[s:FG : s:ATTR]

  return tmuxline#util#tmux_color_attr(fg, bg, attr)
endfun

fun! tmuxline#util#load_colors_from_theme(theme_name) abort
  try
    let colors = tmuxline#themes#{a:theme_name}#get()
  catch /^Vim(let):E117: Unknown function: tmuxline#themes#.*#get/
    throw "tmuxline: Theme cannot be found '" . a:theme_name . "'"
  endtry
  return colors
endfun

fun! tmuxline#util#load_colors_from_hash(hash) abort
  for required_color_name in ['a', 'b', 'c', 'x', 'y', 'z', 'win', 'cwin', 'bg']
    if !has_key(a:hash, required_color_name)
      throw "tmuxline: Theme must define color for '" . required_color_name . "'"
    endif
  endfor
  return deepcopy(a:hash)
endfun

fun! tmuxline#util#load_line_from_preset(preset_name) abort
  try
    let line = tmuxline#presets#{a:preset_name}#get()
  catch /^Vim(let):E117: Unknown function: tmuxline#presets#.*#get/
    throw "tmuxline: Preset cannot be found '" . a:preset_name . "'"
  endtry
  return line
endfun

fun! tmuxline#util#create_line_from_hash(hash) abort
  let hash = deepcopy(a:hash)

  let bar = tmuxline#new()
  let bar.options = get(hash, 'options', {})
  let bar.win_options = get(hash, 'win_options', {})
  let is_win_list_right = get(bar.options, 'status-justify', '') ==# 'right'
  let win_sep_type = is_win_list_right ? 'right' : 'left'

  for key in filter(['a','b','c', 'x', 'y', 'z', 'win', 'cwin'], 'has_key(hash, v:val)')
    let value = hash[key]
    let hash[key] = type(value) == type([]) ? value : [value]
    call map(hash[key], 'escape(v:val, "\"")')
    unlet value
  endfor

  for key in filter(['a','b','c'], 'has_key(hash, v:val)')
    let parts_code = map(copy(hash[key]), '"call bar.left.add(\"" . key . "\", \"" . v:val . "\")"')
    exec join(parts_code, '| call bar.left.add_left_alt_sep() |')
    call bar.left.add_left_sep()
  endfor

  for key in filter(['x','y','z'], 'has_key(hash, v:val)')
    let parts_code = map(copy(hash[key]), '"call bar.right.add(\"" . key . "\", \"" . v:val . "\")"')
    call bar.right.add_right_sep()
    exec join(parts_code, '| call bar.right.add_right_alt_sep() |')
  endfor

  for key in filter(['win'], 'has_key(hash, v:val)')
    let parts_code = map(copy(hash[key]), '"call bar.win.add(\"" . s:DEFAULT_COLOR . "\", \"" . v:val . "\")"')
    exec 'call bar.win.add_' . win_sep_type . '_sep() | call bar.win.add(key, "")'
    exec join(parts_code, '| call bar.win.add_' . win_sep_type . '_alt_sep() |')
    exec 'call bar.win.add(key, "") | call bar.win.add_' . win_sep_type . '_sep()'
  endfor

  for key in filter(['cwin'], 'has_key(hash, v:val)')
    let parts_code = map(copy(hash[key]), '"call bar.cwin.add(\"" . key . "\", \"" . v:val . "\")"')
    exec 'call bar.cwin.add_' . win_sep_type . '_sep()'
    exec join(parts_code, '| call bar.cwin.add_' . win_sep_type . '_alt_sep() |')
    exec 'call bar.cwin.add_' . win_sep_type . '_sep()'
  endfor

  return bar
endfun

fun! tmuxline#util#get_colors_from_vim_statusline() abort
  let stl_fg         = synIDattr(hlID('StatusLine')  , 'fg')
  let stl_bg         = synIDattr(hlID('StatusLine')  , 'bg')
  let stl_reverse    = synIDattr(hlID('StatusLine')  , 'reverse')

  let stl_nc_fg      = synIDattr(hlID('StatusLineNC'), 'fg')
  let stl_nc_bg      = synIDattr(hlID('StatusLineNC'), 'bg')
  let stl_nc_reverse = synIDattr(hlID('StatusLineNC'), 'reverse')

  let stl_attr       = synIDattr(hlID('StatusLine')  , 'bold') ? 'bold' : ''
  let stl_nc_attr    = synIDattr(hlID('StatusLineNC'), 'bold') ? 'bold' : ''

  if stl_fg == -1 || stl_bg == -1 || stl_nc_fg == -1 || stl_nc_bg == -1
    throw "tmuxline: Can't load theme, vim's colorscheme doesn't define StatusLine/StatusLineNC highlight groups"
  endif

  if stl_reverse
    let [ stl_fg, stl_bg ] = [ stl_bg, stl_fg ]
  endif
  if stl_nc_reverse
    let [ stl_nc_fg, stl_nc_bg ] = [ stl_nc_bg, stl_nc_fg ]
  endif

  return {
        \'statusline'             : [ stl_fg,    stl_bg,    stl_attr    ],
        \'statusline_nc'          : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \'reversed_statusline'    : [ stl_bg,    stl_fg,    stl_attr    ],
        \'reversed_statusline_nc' : [ stl_nc_bg, stl_nc_fg, stl_nc_attr ]}
endfun

fun! tmuxline#util#create_theme_from_lightline(mode_palette)
  let theme = {
        \'a' : a:mode_palette.left[s:FG][2:4],
        \'b' : a:mode_palette.left[s:BG][2:4],
        \'c' : a:mode_palette.middle[s:FG][2:4],
        \'x' : a:mode_palette.middle[s:FG][2:4],
        \'y' : a:mode_palette.right[s:BG][2:4],
        \'z' : a:mode_palette.right[s:FG][2:4],
        \'bg' : a:mode_palette.middle[s:FG][2:4],
        \'cwin' : a:mode_palette.left[s:BG][2:4],
        \'win' : a:mode_palette.middle[s:FG][2:4]}
  call tmuxline#util#try_guess_activity_color( theme )
  return theme
endfun

fun! tmuxline#util#create_theme_from_airline(mode_palette)
  let theme = {
        \'a'    : a:mode_palette.airline_a[2:4],
        \'b'    : a:mode_palette.airline_b[2:4],
        \'c'    : a:mode_palette.airline_c[2:4],
        \'x'    : a:mode_palette.airline_x[2:4],
        \'y'    : a:mode_palette.airline_y[2:4],
        \'z'    : a:mode_palette.airline_z[2:4],
        \'bg'   : a:mode_palette.airline_c[2:4],
        \'cwin' : a:mode_palette.airline_b[2:4],
        \'win'  : a:mode_palette.airline_c[2:4]}
  call tmuxline#util#try_guess_activity_color( theme )
  return theme
endfun

" use background in 'a' section for windows with activity alert
" but use the color only if it's different from the other windows and the background
fun! tmuxline#util#try_guess_activity_color(theme)
  let bg           = a:theme.bg[s:BG]
  let a_section_bg = a:theme.a[s:BG]
  let win_fg       = a:theme.win[s:FG]
  if a_section_bg != bg && a_section_bg != win_fg
    let a:theme['win.activity'] = [ a_section_bg, bg, 'none' ]
  endif

  return a:theme
endfun
