
function! tmuxline#themes#vim_statusline1#get()

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
        \ 'a'    : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \ 'b'    : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \ 'c'    : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \ 'x'    : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \ 'y'    : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \ 'z'    : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \ 'bg'   : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \ 'win'  : [ stl_nc_fg, stl_nc_bg, stl_nc_attr ],
        \ 'cwin' : [ stl_fg   , stl_bg, stl_attr    ],
        \ 'pane' : [ stl_nc_bg, stl_nc_bg ],
        \ 'cpane': [ stl_bg   , stl_bg ]}
endfunc
