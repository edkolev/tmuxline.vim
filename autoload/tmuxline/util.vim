" The MIT License (MIT)
"
" Copyright (c) 2013 Evgeni Kolev

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

fun! tmuxline#util#get_color_definition_from_theme(color_name, theme)
  if has_key(a:theme, a:color_name)
    return a:theme[a:color_name]
  else
    let downgraded_color_name = substitute(a:color_name, '\..*', '', '')
    if has_key(a:theme, downgraded_color_name)
      " echohl WarningMsg
      " echo "tmuxline warning: Using color '" . downgraded_color_name . "' instead of '" . a:color_name . "'"
      " echohl None
      return a:theme[downgraded_color_name]
    else
      throw "tmuxline error: Color definition '" . a:color_name . "' not found in theme"
    endif
  endif
endfun

fun! tmuxline#util#get_color_from_theme(color_name, theme) abort
  let color_definition = tmuxline#util#get_color_definition_from_theme(a:color_name, a:theme)

  let fg = color_definition[0]
  let bg = color_definition[1]
  let attr = get(color_definition, 2, '')
  return tmuxline#util#tmux_color_attr(fg, bg, attr)
endfun

fun! tmuxline#util#load_colors_from_theme(theme_name) abort
  try
    let colors = tmuxline#themes#{a:theme_name}#get()
  catch
    throw "tmuxline error: invalid theme \"" . a:theme_name . "\""
  endtry
  return colors
endfun

fun! tmuxline#util#load_line_from_preset(preset_name) abort
  try
    let line = tmuxline#presets#{a:preset_name}#get()
  catch
    throw "tmuxline error: invalid preset \"" . a:preset_name . "\""
  endtry
  return line
endfun

" XXX ugly. try to find a better way to create a tmuxline from a hash
fun! tmuxline#util#create_line_from_hash(hash) abort
  let bar = tmuxline#new()
  let hash = deepcopy(a:hash)

  for key in filter(['a','b','c'], 'has_key(hash, v:val)')
    let value = hash[key]
    let parts = type(value) == type([]) ? value : [value]
    call map(parts, 'escape(v:val, "\"")')
    let parts_code = map(copy(parts), '"call bar.left.add(\"" . key . "\", \"" . v:val . "\")"')
    exec join(parts_code, '| call bar.left.add_left_alt_sep() |')
    call bar.left.add_left_sep()
    unlet value
  endfor

  for key in filter(['x','y','z'], 'has_key(hash, v:val)')
    let value = hash[key]
    let parts = type(value) == type([]) ? value : [value]
    call map(parts, 'escape(v:val, "\"")')
    let parts_code = map(copy(parts), '"call bar.right.add(\"" . key . "\", \"" . v:val . "\")"')
    call bar.right.add_right_sep()
    exec join(parts_code, '| call bar.right.add_right_alt_sep() |')
    unlet value
  endfor

  for key in filter(['win'], 'has_key(hash, v:val)')
    let value = hash[key]
    let parts = type(value) == type([]) ? value : [value]
    call map(parts, 'escape(v:val, "\"")')
    let parts_code = map(copy(parts), '"call bar.win.add(\"" . key . "\", \"" . v:val . "\")"')
    call bar.win.add_left_sep()
    exec join(parts_code, '| call bar.win.add_left_alt_sep() |')
    call bar.win.add_left_sep()
    unlet value
  endfor

  for key in filter(['cwin'], 'has_key(hash, v:val)')
    let value = hash[key]
    let parts = type(value) == type([]) ? value : [value]
    call map(parts, 'escape(v:val, "\"")')
    let parts_code = map(copy(parts), '"call bar.cwin.add(\"" . key . "\", \"" . v:val . "\")"')
    call bar.cwin.add_left_sep()
    exec join(parts_code, '| call bar.cwin.add_left_alt_sep() |')
    call bar.cwin.add_left_sep()
    unlet value
  endfor

  let bar.options = get(hash, 'options', {})
  let bar.win_options = get(hash, 'win_options', {})

  return bar
endfun

fun! tmuxline#util#create_theme_from_airline(mode_palette)
  return {
        \'a'    : a:mode_palette.airline_a[2:4],
        \'b'    : a:mode_palette.airline_b[2:4],
        \'c'    : a:mode_palette.airline_c[2:4],
        \'x'    : a:mode_palette.airline_x[2:4],
        \'y'    : a:mode_palette.airline_y[2:4],
        \'z'    : a:mode_palette.airline_z[2:4],
        \'bg'   : a:mode_palette.airline_c[2:4],
        \'cwin' : a:mode_palette.airline_b[2:4],
        \'win'  : a:mode_palette.airline_c[2:4]}
endfun

