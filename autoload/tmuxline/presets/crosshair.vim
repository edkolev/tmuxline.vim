fun! tmuxline#presets#crosshair#get()
  let bar = tmuxline#new()

  call bar.left.add('a', '#S')
  call bar.left.add_left_sep()
  call bar.left.add('c', '%H:%M')

  call bar.right.add('x', '%d %b')
  call bar.right.add_right_sep()
  call bar.right.add('z', '#h')

  call bar.win.add('win', '#I | #W')

  call bar.cwin.add_left_sep()
  call bar.cwin.add('cwin', '#I')
  call bar.cwin.add_left_alt_sep()
  call bar.cwin.add('cwin', '#W')
  call bar.cwin.add_right_alt_sep()
  call bar.cwin.add('cwin', '#P')
  call bar.cwin.add_right_sep()

  let bar.options['status-justify'] = 'centre'
  let bar.win_options['window-status-activity-attr'] = 'none'
  let bar.win_options['window-status-separator'] = ' '

  return bar
endfun

