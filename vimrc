set nocompatible

" Show a more meaningful window title
set title

" Show line numbers
set number

" Show row/column number thingie in lower-right corner
set ruler

" Treat tabs as tabs, three spaces wide.  (Yes, I'm weird.)
set tabstop=3
set shiftwidth=3
set noexpandtab

" Use brighter for text colors (assumes we've got a dark background)
"set background=dark

" Experimenting with a colorscheme
colorscheme desert

" Set some nicer search options
set incsearch
set hlsearch
set ignorecase
set smartcase

" Make backspace work as one would expect in Insert mode
set backspace=indent,eol,start

syntax on

" Aiming for reasonable language-aware indenting
set autoindent
filetype on
filetype plugin on
filetype indent on

" Decent search behavior
set incsearch
set ignorecase
set smartcase
set hlsearch

" Bash-style filename autocomplete
set wildmode=longest,list

" Wrap at word breaks (don't wrap in mid-word), without inserting newline characters automatically
set wrap
set linebreak
set nolist " (I guess list would disable linebreak...)

" Keep a little more vertical context around the cursor
set scrolloff=3

" Map some useful spell-checking command
:map <leader>ss :set spell!<CR>
:map <leader>sn ]s
:map <leader>sN [s
:map <leader>s? z=

