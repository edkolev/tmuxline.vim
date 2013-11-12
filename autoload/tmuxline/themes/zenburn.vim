" TODO
function! tmuxline#themes#zenburn#get()

    " return {
    "     \ 'a': [ '#233323', '#71d3b4'  ],
    "     \ 'b': [ '#93b3a3', '#3f4040' ],
    "     \ 'c': [ '#404040', '236'],
    "     \ 'x': [ '74', '236'],
    "     \ 'y': [ '153', '59' ],
    "     \ 'z': [ '#233323', '#71d3b4'  ],
    "     \ 'bg': [ '', '236'],
    "     \ 'win': [ '74', '236'],
    "     \ 'cwin': [ '59', '74'  ]}

    return {'a'      : ['colour237', 'colour109'],
          \'b'       : ['colour109', 'colour236'],
          \'bg'      : ['colour240', 'colour237'],
          \'c'       : ['colour240', 'colour237'],
          \'win'    : ['colour109', 'colour237'],
          \'cwin'     : ['colour237', 'colour109'],
          \'x'       : ['colour240', 'colour237'],
          \'y'       : ['colour109', 'colour236'],
          \'z'       : ['colour237', 'colour109']}

endfunc
