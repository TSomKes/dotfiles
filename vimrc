set nocompatible

set noswapfile

" Basic display 
set title
set number
set ruler

set hidden      " Allow navigating away from unsaved buffers

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Colors
set background=dark
colorscheme desert

" Make 'tabe' foreground colors dimmer for non-active tabs
" ...I just wish this worked.  (Maybe it's a problem with syntax higlighting
" happening after this setting?)
"highlight TabLine ctermfg=Gray ctermbg=Black

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

" Allow :find to look in other directory levels
" -   This is a mystery to me.  Must learn more.
" -   via https://www.youtube.com/watch?v=XA2WjJbmmoM
set path+=**

" Ignore build directory for vim :find
" (Originally done for Gogy webservice work.  Will this play poorly with some
" other project directories?)
set wildignore+=**/build/**

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

:map <leader>sh :nohl<CR>

:map <leader>sr :set relativenumber!<CR>

" ctags (exuberant ctags)
:command Retag !ctags -R *

" Allow use of tags file in parent directory, per
" http://vim.wikia.com/wiki/Single_tags_file_for_a_source_tree
:set tags=tags;

" A little help with git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72
