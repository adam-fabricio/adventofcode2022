"-------sintax--------------!
syntax on
filetype plugin indent on
colorscheme desert

"-------Função para remover espa~ço no fina da linha"
map <leader-c> "+yy
map <leader-v> "+p
map gA ggVG"+y
map <C-q> :quit<CR>
map <C-s> :w<CR>
map <C-x> :x<CR>

"----set---
set list
set background=dark
set backspace=indent,eol,start
set binary
set colorcolumn=80
set cursorline
set encoding=utf-8 nobomb
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak 
set listchars=tab:»\ ,trail:␣,extends:▶,precedes:◀
set modeline
set modelines=4
set mouse=a
set nocompatible
set nowrap
set number
set ruler
set scrolloff=3
set smartcase 
set showcmd
set showmode
set showmatch
set scrolloff=1
set softtabstop=4 
set shiftwidth=4 
set title
set tabstop=4 
set ttyfast
"set tw=79
set wildmenu
