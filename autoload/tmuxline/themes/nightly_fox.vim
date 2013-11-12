" The MIT License (MIT)
"
" Copyright (c) 2013 Evgeni Kolev

" inspired by http://paulrouget.com/e/myconf/

function! tmuxline#themes#nightly_fox#get()
    return {
        \ 'a'       : [ 198, 16 ],
        \ 'b'       : [ 208, 16 ],
        \ 'c'       : [ 208, 16 ],
        \ 'x.dim'   : [ 243, 16 ],
        \ 'x'       : [ 208, 16 ],
        \ 'y.dim'   : [ 243, 16 ],
        \ 'y'       : [ 208, 16 ],
        \ 'z'       : [ 198, 16 ],
        \ 'bg'      : [ '', 16],
        \ 'win'     : [ 231, 16 ],
        \ 'win.dim' : [ 243, 16 ],
        \ 'cwin'    : [ 16, 231, 'bold']}
endfunc

" set -g status-bg black
" set -g status-fg white

" set -g status-left ' #[default]'
" set -g status-right '#[fg=colour235]Inbox: #[fg=yellow]#(ls ~/Mails/INBOX/new | wc -l | tr -d " ")#[fg=colour235]/#(ls ~/Mails/INBOX/cur  ~/Mails/INBOX/new | wc -l | tr -d " ") | Bugzilla: #[fg=yellow]#(ls ~/Mails/bugzilla/new | wc -l | tr -d " ")#[fg=colour235]/#(ls ~/Mails/bugzilla/cur ~/Mails/bugzilla/new| wc -l | tr -d " ") | ml: #[fg=yellow]#(ls ~/Mails/lists/new | wc -l | tr -d " ")#[fg=colour235]/#(ls ~/Mails/lists/cur ~/Mails/lists/new | wc -l | tr -d " ")#[default]  #[fg=colour198]%H:%M#[default]'

" setw -g window-status-format '#[fg=colour235]#I #[fg=white]#W#[default]  '
" setw -g window-status-current-format '#[bg=white,fg=black]⮀ #W #[bg=black,fg=white]⮀'

