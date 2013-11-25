# tmuxline.vim

Simple tmux statusline generator with support for powerline symbols and airline integration

![img](https://f.cloud.github.com/assets/1532071/1556058/d2347eea-4ea7-11e3-9393-660b2e2c143a.png)

## Features

- use [vim-airline][7] colors, so tmux and vim share the same statusline colortheme
- preloaded with stock themes and presets, which can be combined anyway you want
- configure tmux statusline using a simple hash, in case stock presets don't meet your needs
- create a snapshot .conf file which can be sourced by tmux, no need to open vim to set your tmux statusline

## Usage

Set a a colortheme and a preset, both arguments are optional
```
:Tmuxline [theme] [preset]
```

After running :Tmuxline, create a snapshot file which can be sourced by tmux.conf
```
:TmuxlineSnapshot [file]
```

Source the created snapshot in tmux.conf
```
# in tmux.conf
source-file [file]

# alternatively, check file exists before sourcing it in tmux.conf
if-shell "test -f [file]" "source [file]"
```

Note that :Tmuxline and :TmuxlineSnapshot are available inside vim only.

## Configuration

### vim-airline

Just start vim inside of tmux. airline's colors will be applied to tmux's statusline

![img](https://f.cloud.github.com/assets/1532071/1556059/d24a5c42-4ea7-11e3-9965-c13418d889a1.png)

### Configuration

#### Stock preset

Set `g:tmuxline_preset` to a stock preset and run `:Tmuxline`

```
let g:tmuxline_preset = 'nightly_fox'
" or
let g:tmuxline_preset = 'full'
" or
let g:tmuxline_preset = 'tmux'
" other presets available in autoload/tmuxline/presets/*
```

#### Custom preset

Contents of the statusline are configured with a simple hash.
Left section is configured with `a, b, c`, right with `x, y, z`. `cwin` and `win` affect the current (active) window and the in-active windows respectively.
```
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a',
      \'y'    : '#W %R',
      \'z'    : '#H'}
```

![img](https://f.cloud.github.com/assets/1532071/1556060/d80f24a0-4ea7-11e3-97c2-0e5fd39dbf2b.png)


tmux will replace #X and %X. Excerpts from tmux man page:
```
#H    Hostname of local host
#h    Hostname of local host without the domain name
#F    Current window flag
#I    Current window index
#S    Session name
#W    Current window name
#(shell-command)  First line of the command's output

string will be passed through strftime(3) before being used.
```

If the values of the hash `g:tmuxline_preset` hold an array, a powerline separator will be placed.
```
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : '#H'}
```

![img](https://f.cloud.github.com/assets/1532071/1556061/d81ab112-4ea7-11e3-9be7-46e41cc47cef.png)

tmux allows using any command in the statusline.
```
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'x'    : '#(date)',
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : '#H'}
```

![img](https://f.cloud.github.com/assets/1532071/1556062/d82660ca-4ea7-11e3-9df3-4b084a992c0c.png)

use `let g:tmuxline_powerline_separators = 0` to disable using powerline symbols

## Inspired by

- Paul Rouget's [desktop setup][1]
- Bailey Ling's [vim-airline][2]

## Rationale

Vimscript wasn't my first choice of language for this plugin. Arguably, bash would have been better suited for this task. I chose vimscript because:
- its data scructures (arrays, hashes) are better than their bash counterparts (easier to write, to maintain). So maintaining your tmux statusline as a vim hash would be easier
- vim has (better) package managers

Somewhat-similar plugins:
- [powerline][3] is a great project. Still, my [Raspberri Pi][5] chokes while executing python every [2 seconds][6] (I haven't tried powerline's daemon mode). I also find it a bit hard to personalize
- [tmux-powerline][4] doesn't focus on easy customization but on adding extra information (segments) in tmux (gmail, weather, earthquake warnings, etc)

## License

MIT License. Copyright (c) 2013 Evgeni Kolev.

[1]: http://paulrouget.com/e/myconf/
[2]: https://github.com/bling/vim-airline
[3]: https://github.com/Lokaltog/powerline
[4]: https://github.com/erikw/tmux-powerline
[5]: http://www.raspberrypi.org/
[6]: https://github.com/Lokaltog/powerline/blob/82842e015cda89fb48b1256d34c53f964e2fa151/powerline/bindings/tmux/powerline.conf#L4
[7]: https://github.com/bling/vim-airline
