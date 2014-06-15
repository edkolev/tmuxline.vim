
function! tmuxline#themes#vim_statusline2#get()

  let stl_fg         = synIDattr(hlID('StatusLine')  , 'fg')
  let stl_bg         = synIDattr(hlID('StatusLine')  , 'bg')
  let stl_reverse    = synIDattr(hlID('StatusLine')  , 'reverse')

  let stl_nc_fg      = synIDattr(hlID('StatusLineNC'), 'fg')
  let stl_nc_bg      = synIDattr(hlID('StatusLineNC'), 'bg')
  let stl_nc_reverse = synIDattr(hlID('StatusLineNC'), 'reverse')

  let stl_attr       = synIDattr(hlID('StatusLine')  , 'bold') ? 'bold' : ''
  let stl_nc_attr    = synIDattr(hlID('StatusLineNC'), 'bold') ? 'bold' : ''

  if stl_reverse
    let [ stl_fg, stl_bg ] = [ stl_bg, stl_fg ]
  endif
  if stl_nc_reverse
    let [ stl_nc_fg, stl_nc_bg ] = [ stl_nc_bg, stl_nc_fg ]
  endif

  return {
        \ 'a'    : [ stl_fg, stl_bg, stl_attr ],
        \ 'b'    : [ stl_fg, stl_bg, stl_attr ],
        \ 'c'    : [ stl_fg, stl_bg, stl_attr ],
        \ 'x'    : [ stl_fg, stl_bg, stl_attr ],
        \ 'y'    : [ stl_fg, stl_bg, stl_attr ],
        \ 'z'    : [ stl_fg, stl_bg, stl_attr ],
        \ 'bg'   : [ stl_fg, stl_bg, stl_attr ],
        \ 'win'  : [ stl_fg, stl_bg, stl_attr ],
        \ 'cwin' : [ stl_nc_fg   , stl_nc_bg,    stl_nc_attr    ],
        \ 'pane' : [ stl_nc_bg, stl_nc_bg ],
        \ 'cpane': [ stl_bg   , stl_bg ]}
endfunc
