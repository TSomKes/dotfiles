setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab

" Shortcut for turning on colorcolumn (at textwidth+1)
map <leader>sc :set colorcolumn=+1<CR>

" F5 --> save & execute
nmap <buffer> <F5> :w<CR> :!python %<CR>
