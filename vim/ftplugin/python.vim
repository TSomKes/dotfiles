setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal smarttab
setlocal expandtab
"setlocal noexpandtab
"set tabstop=8
"set shiftwidth=8

" Highlight trailing whitespace
set list listchars=trail:.

" Shortcut for turning on colorcolumn (at textwidth+1)
map <leader>sc :set colorcolumn=+1<CR>

" F5 --> save & execute
nmap <buffer> <F5> :w<CR> :!python3 %<CR>

" F6 --> PEP8
nmap <buffer> <F6> :w<CR> :! pep8 --count %<CR>

" F7 --> pyflakes
nmap <buffer> <F7> :w<CR> :! pyflakes %<CR>
