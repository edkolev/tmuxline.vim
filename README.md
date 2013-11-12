# tmuxline.vim

Simple tmux statusline generator with support for powerline symbols

## Features

- preloaded with stock themes and presets, which can be combined anyway you want
- configure tmux statusline using a simple hash, in case stock presets don't meet your needs
- create a snapshot .conf file which can be sourced by tmux, no need to open vim to set your tmux statusline

## Screenshots

## Example configuration in .vimrc

```
TODO better one with and without arrays
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#H', '#H'],
      \'win'  : '#I #W',
      \'cwin' : ['#I', '#W'],
      \'x'    : ['#I', '#W'],
      \'z'    : '#W %R'}

" tmux will replace #X. Quote from tmux man page:
"
" #H		     Hostname of local host
" #h		     Hostname of local host without the domain name
" #F		     Current window flag
" #I		     Current window index
" #S		     Session name
" #W		     Current window name
" ##		     A literal `#'
" #(shell-command)  First line of the command's output
```

## Snaptshot

## Inspired by

- Paul Rouget's [desktop setup][1]
- Bailey Ling's [vim-airline][2]

## Rationale

Vimscript wasn't my first choice of language for this plugin. Arguably, bash would have been better suited for this tasks. I chose vimscript because:
- its data scructures (arrays, hashes) are much better than their bash counterparts. So maintaining your tmux statusline as a vim hash would be easier
- vim has (better) package managers

This plugin does few things only (easy configuration of tmux statusline's color and contents), but tries to do them as good as possible.

I'm not aware of another plugin with igendical scope, so I can't compare apples with apples in this case.

- [powerline][3] is a great project. Still, my [Raspberri Pi][5] chokes while executing python every [2 secons][6] (I haven't tried powerline's daemon mode)
- [tmux-powerline][4] doesn't focus on easy customization but on adding extra information (segments) in tmux (gmail, weather, earthquake warnings, etc)

## License

MIT License. Copyright (c) 2013 Evgeni Kolev.

[1]: http://paulrouget.com/e/myconf/
[2]: https://github.com/bling/vim-airline
[3]: https://github.com/Lokaltog/powerline
[4]: https://github.com/erikw/tmux-powerline
[5]: http://www.raspberrypi.org/
[6]: https://github.com/Lokaltog/powerline/blob/82842e015cda89fb48b1256d34c53f964e2fa151/powerline/bindings/tmux/powerline.conf#L4
