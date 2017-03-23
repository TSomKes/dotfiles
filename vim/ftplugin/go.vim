" gofmt calls for 8-space tabs.  Going with the flow.
setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=8


" F5 --> save, test-build & execute
nmap <buffer> <F5> :w<CR> 
    \ :! go build %<CR> 
    \ :! go run %<CR>

" F6 --> save & gofmt (overwriting file), then reload tab
nmap <buffer> <F6> :w<CR> 
    \ :! gofmt -w %<CR><CR> 
    \ :e<CR>
