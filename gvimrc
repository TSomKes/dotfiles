"set background=light

" Turn off some GUI stuff
if has('gui_running')
		set guioptions-=T
		set guioptions-=m
		set guioptions-=r
endif

" Slightly bigger window
set columns=120
set lines=50

" Playint with zenburn; getting rid of that foggy color
let g:zenburn_high_Contrast=1
colorscheme zenburn
