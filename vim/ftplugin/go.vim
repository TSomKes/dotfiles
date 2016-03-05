" F4 --> save & gofmt (overwriting file)
nmap <buffer> <F4> :w<CR> :! gofmt -w %<CR><CR> :e<CR>

" F5 --> save & execute
nmap <buffer> <F5> :w<CR> :! go run %<CR>

" F6 --> save & test
nmap <buffer> <F6> :w<CR> :! go test %<CR>
