set nocompatible

syntax enable

set backspace=2 			"Make backspace work like most other programs.
let mapleader = "," 			"The default is \.
set number				"Activate line numbers.
set noerrorbells visualbell t_vb=	"No bells!

"---------- Search -----------"
set hlsearch
set incsearch

"---------- Mappings -----------"

"Make it easy to edit the vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Highlight removal.
nmap <Leader><space> :nohlsearch<cr>


"---------- Splits -----------"
set splitbelow
set splitright


"Only works for splits
" :vsp Opens a vertical split
" :sp  Opens a horizontal split
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"---------- Auto-Commands -----------"

"Automatically source the vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

