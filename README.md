# tmuxline.vim

Simple tmux statusline generator with support for powerline symbols and vim/airline/lightline statusline integration

- colors from [vim-airline][7]/[lightline.vim][12]

![img](https://f.cloud.github.com/assets/1532071/1556058/d2347eea-4ea7-11e3-9393-660b2e2c143a.png)

- colors from vim's own [statusline][13]

![img](https://cloud.githubusercontent.com/assets/1532071/3634460/5b2858f4-0f30-11e4-925c-bf555bb65806.png)

## Features

- use [vim][13]/[vim-airline][7]/[lightline.vim][12] colors, so tmux and vim share the same statusline colortheme
- preloaded with stock themes and presets, which can be combined anyway you want
- configure tmux statusline using a simple hash, in case stock presets don't meet your needs
- create a snapshot .conf file which can be sourced by tmux, no need to open vim to set your tmux statusline

## Quickstart

#### use vim's statusline colors

Use one of the `vim_statusline_*` themes (and optionally set in vimrc `let g:tmuxline_powerline_separators = 0`):

```
:Tmuxline vim_statusline_1
" or
:Tmuxline vim_statusline_2
" or
:Tmuxline vim_statusline_3
```

![img](https://cloud.githubusercontent.com/assets/1532071/3787457/dc6ef76c-1a19-11e4-8d77-964e7db87337.png)

#### use vim-airline colors

Just start vim inside of tmux. airline's colors will be applied to tmux's statusline

![img](https://f.cloud.github.com/assets/1532071/1556059/d24a5c42-4ea7-11e3-9965-c13418d889a1.png)

Alternatively, you can set it manually using `airline_*` themes:
```
:Tmuxline airline
" or
:Tmuxline airline_insert
" or
:Tmuxline airline_visual
```

If you set airline theme manually, make sure the [airline-tmuxline][11] extension  is disabled, so it doesn't overwrite the theme:

`let g:airline#extensions#tmuxline#enabled = 0`

#### use lightline.vim colors

Use one of the `lightline_*` themes:
```
:Tmuxline lightline
" or
:Tmuxline lightline_insert
" or
:Tmuxline lightline_visual
```

![img](https://f.cloud.github.com/assets/1532071/2058566/ec64bf70-8b77-11e3-883f-82b41a83f6ac.png)

## Usage

Set a a colortheme and a preset, both arguments are optional
```
:Tmuxline [theme] [preset]
```

After running :Tmuxline, create a snapshot file which can be sourced by tmux.conf on startup
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

Note that `:Tmuxline` and `:TmuxlineSnapshot` are available only when vim is inside a tmux session.

## Configuration

### Stock preset

Set `g:tmuxline_preset` to a stock preset and run `:Tmuxline`

```
let g:tmuxline_preset = 'nightly_fox'
" or
let g:tmuxline_preset = 'full'
" or
let g:tmuxline_preset = 'tmux'
" other presets available in autoload/tmuxline/presets/*
```

### Custom preset

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

### Separators

Use `let g:tmuxline_powerline_separators = 0` to disable using powerline symbols

To fine-tune the separators, use `g:tmuxline_separators`:
```
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '>',
    \ 'right' : '',
    \ 'right_alt' : '<',
    \ 'space' : ' '}
```

### Theme

Note that [vim-airline][2] has a [tmuxline extenstion][11] which by default sets airline's color theme onto tmuxline.
If you don't want airline colors in tmuxline, set `let g:airline#extensions#tmuxline#enabled = 0` in vimrc.

Modifying `g:tmuxline_theme` (details below) makes sense only if the airline-tmuxline is not enabled.

Use `g:tmuxline_theme` to configure the theme. `g:tmuxline_theme` can hold either a string (stock theme) or a hash (custom theme).

```
let g:tmuxline_theme = 'icebert'
" or
let g:tmuxline_theme = 'zenburn'
" or
let g:tmuxline_theme = 'jellybeans'
" other themes available in autoload/tmuxline/themes/*
```

Alternatively, `g:tmuxline_theme` can be used to fine tune a custom theme:

```
let g:tmuxline_theme = {
    \   'a'    : [ 236, 103 ],
    \   'b'    : [ 253, 239 ],
    \   'c'    : [ 244, 236 ],
    \   'x'    : [ 244, 236 ],
    \   'y'    : [ 253, 239 ],
    \   'z'    : [ 236, 103 ]
    \   'win'  : [ 103, 236 ],
    \   'cwin' : [ 236, 103 ],
    \   'bg'   : [ 244, 236 ],
    \ }
" values represent: [ FG, BG, ATTR ]
"   FG ang BG are color codes
"   ATTR (optional) is a comme-delimited string of one or more of bold, dim, underscore, etc. For details refer to 'message-attr attributes' in tmux man page
```

## Installation

The plugin's files follow the standard layout for vim plugins.

- [Pathogen][8] `git clone https://github.com/edkolev/tmuxline.vim ~/.vim/bundle/tmuxline.vim`
- [Vundle][9] `Bundle 'edkolev/tmuxline.vim'`
- [NeoBundle][10] `NeoBundle 'edkolev/tmuxline.vim'`

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

MIT License. Copyright (c) 2013-2014 Evgeni Kolev.

[1]: http://paulrouget.com/e/myconf/
[2]: https://github.com/bling/vim-airline
[3]: https://github.com/Lokaltog/powerline
[4]: https://github.com/erikw/tmux-powerline
[5]: http://www.raspberrypi.org/
[6]: https://github.com/Lokaltog/powerline/blob/82842e015cda89fb48b1256d34c53f964e2fa151/powerline/bindings/tmux/powerline.conf#L4
[7]: https://github.com/bling/vim-airline
[8]: https://github.com/tpope/vim-pathogen
[9]: https://github.com/gmarik/vundle
[10]: https://github.com/Shougo/neobundle.vim
[11]: https://github.com/bling/vim-airline#tmuxline
[12]: https://github.com/itchyny/lightline.vim
[13]: http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline'

