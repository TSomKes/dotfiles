set nocompatible

" Basic display 
set title
set number
set ruler

" Tabs are tabs, three spaces wide.  (Yes, weird.)
set tabstop=3
set shiftwidth=3
set noexpandtab

" Colors
set background=dark
colorscheme desert

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Make backspace work as one would expect in Insert mode
set backspace=indent,eol,start

" Language-awareness, etc.
syntax on
filetype on
filetype plugin on
filetype indent on
set autoindent

" Bash-style filename autocomplete
set wildmode=longest,list

" Word wrapping
set wrap
set linebreak
set nolist " (I guess list would disable linebreak...)

" Keep a little more vertical context around the cursor
set scrolloff=3

" People seem to like setting the leader to ,
let mapleader = ","

" Map some useful spell-checking command
:map <leader>ss :set spell!<CR>
:map <leader>sn ]s
:map <leader>sp [s
:map <leader>sc z=

" Whitespace toggle
:map <leader>sl :set list!<CR>

:map <leader>sh :set hlsearch!<CR>

" A little help with git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72
