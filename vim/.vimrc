filetype indent plugin on
syntax on

set number
set relativenumber

colorscheme murphy
set termguicolors

set cursorline
set guicursor=n-c-v:block,i-ci-ve:ver25,r:ho25

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

set ignorecase
set smartcase
set hlsearch
set incsearch

set mouse=a
set clipboard=unnamedplus
set scrolloff=5
set nowrap

if &term=~'xterm'
	let &t_SI="\e[6 q"
	let &t_SR="\e[4 q"
	let &t_EI="\e[2 q"
endif
