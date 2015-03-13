" F4 --> save & gofmt (overwriting file)
nmap <buffer> <F4> :w<CR> :! gofmt -w %<CR>

" F5 --> save & execute
nmap <buffer> <F5> :w<CR> :! go run %<CR>
