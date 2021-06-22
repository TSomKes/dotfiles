set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="tsomkes"

" 256 color cheatsheet:  https://jonasjacek.github.io/colors/
"
" Note:  fg & bg are reversed on some groups.  The ctermfg & ctermbg ordering
" reflects this.

"  Group            Foreground  Background  Misc.

hi Normal           ctermfg=7   ctermbg=232

" "Preferred" groups 
" (per :help highlighting-groups --> NAMING CONVENTIONS)
hi Comment          ctermfg=71
hi Constant         ctermfg=7
hi Identifier       ctermfg=7               cterm=none
hi Statement        ctermfg=7
hi PreProc          ctermfg=7
hi Type             ctermfg=7
hi Special          ctermfg=7
hi Underlined       ctermfg=7               cterm=underline
hi Ignore           ctermfg=7
hi Error            ctermfg=9   ctermbg=232
hi Todo             ctermfg=220 ctermbg=232

" Some stragglers that weren't covered by the above defaults
hi Title            ctermfg=75

" Overrides
hi LineNr           ctermfg=245
hi ColorColumn                  ctermbg=235
hi String           ctermfg=176
hi SpellBad                     ctermbg=88

hi IncSearch        ctermbg=7   ctermfg=25
hi Search           ctermfg=7   ctermbg=25

" Git diffs
" see https://stackoverflow.com/questions/30247603/
hi DiffAdded        ctermfg=83
hi DiffRemoved      ctermfg=160
