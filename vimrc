set nocompatible

set noswapfile

" Basic display 
set title
set number
set ruler

" Allow navigating away from unsaved buffers
set hidden

" Tabs
" (Good overview:  http://vimcasts.org/episodes/tabs-and-spaces/)
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Colors
set background=dark
"colorscheme desert
colorscheme tsomkes

" Fix background color re-drawing problems
set t_ut=""

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Make backspace work as one would expect in Insert mode
" (see https://vi.stackexchange.com/a/2163/29033)
set backspace=indent,eol,start

" Language-awareness, etc.
syntax on
filetype on
filetype plugin on
filetype indent on
set autoindent

" Allow :find to look in other directory levels
" - https://www.youtube.com/watch?v=XA2WjJbmmoM
" - https://www.reddit.com/r/vim/comments/8mi8cm/is_using_in_path_a_good_idea/
" Note:  Tim Pope hates this
" (https://twitter.com/tpope/status/612991904897232898).
" Makes me think I should look into alternatives.
set path+=**

" Ignore build directory for vim :find
" (Originally done for Gogy webservice work.  Will this play poorly with some
" other project directories?)
"set wildignore+=**/build/**

" Avoid searching all imported files for ctrl+p
set wildignore+=*/venv/*

" Bash-style filename autocomplete (list, don't change input with suggestion).
set wildmode=longest,list

" Word wrapping
set wrap
set linebreak
set nolist " (I guess list would disable linebreak...)

" Keep a little more vertical context around the cursor
set scrolloff=12

" Allow use of tags file in parent directory, per
" http://vim.wikia.com/wiki/Single_tags_file_for_a_source_tree
set tags=tags;


" Commands
" --------

" A little help with git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" Unfold on open
" - via https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
autocmd BufRead * normal zR

" ctags (exuberant ctags)
:command! Retag !ctags -R *


" Useful Key Sequences
" --------------------

" People seem to like setting the leader to ,
let mapleader = ","

" Map some useful spell-checking command
:map <leader>ss :set spell!<CR>

" Whitespace toggle
:map <leader>sl :set list!<CR>

:map <leader>s/ :nohl<CR>

:map <leader>sr :set relativenumber!<CR>

" Toggle colorcolumn (column 80) 
" (via https://vi.stackexchange.com/a/17574)
:map <leader>sc :execute "set cc=" . (&cc == "" ? 80 : "")<CR>

" Load project-specific .vimlocal files (failing silently)
silent! source .vimlocal

" Markdown
" let g:markdown_folding = 1

" vim/tmux copy-pasting
" (via https://squidarth.com/programming/2018/12/14/tmux-linux.html)
" and https://medium.com/@squidarth/a-better-copy-paste-flow-for-tmux-on-macos-5284f82571a2)
set clipboard=unnamedplus
