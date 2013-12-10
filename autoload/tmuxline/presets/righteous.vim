fun! tmuxline#presets#righteous#get()
  return tmuxline#util#create_line_from_hash({
        \'a'       : '#S',
        \'b'       : ['#I:#P','#F'],
        \'c'       : ['#H'],
        \'win'     : ['#I','#W'],
        \'cwin'    : ['#I','#W'],
        \'y'       : '%H:%M %d-%b-%y',
        \'options' : {'status-justify' : 'right'}})
endfun
