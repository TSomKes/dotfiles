" gofmt calls for 8-space tabs.  Going with the flow.
" ...except that I've snapped, and am cutting them in half for now
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4


" F5 --> save, test-build & execute
nmap <buffer> <F5> :w<CR> 
    \ :! go run %<CR>
"    \ :! go build %<CR> " test-building seems overkill for my toy apps; skip

" F6 --> save & gofmt (overwriting file), then reload tab
nmap <buffer> <F6> :w<CR> 
    \ :! gofmt -w %<CR><CR> 
    \ :e<CR>
