set nocompatible
set t_Co=256
filetype off
syntax on
set encoding=utf-8
set ttyfast
set lazyredraw
set number
set hidden
set exrc
set backspace=indent,eol,start
set history=50
set autoread
set ruler
set wildmenu
set wildmode=list:longest
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.pdf,*.psd
set cursorline
set showcmd
set laststatus=2
set autochdir
set nobackup
set nowb
set noswapfile
set splitbelow
set splitright
set iskeyword-=_
set relativenumber
set clipboard=unnamed
set clipboard^=unnamedplus

" =====================================================================
" COLORSCHEME
" =====================================================================

colorscheme nord

" =====================================================================
" FUNCTIONS
" =====================================================================

function s:set_cursor_line()
    set cursorline
    hi cursorline cterm=NONE
endfunction

autocmd VimEnter * call s:set_cursor_line()
autocmd BufWritePre * %s/\s\+$//e

" =====================================================================
" SEARCH
" =====================================================================

set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch
set mousehide

" =====================================================================
" INDENTATION
" =====================================================================

set autoindent
set nowrap
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent

" =====================================================================
" SCROLLING
" =====================================================================

set scrolloff=4
set sidescrolloff=15
set sidescroll=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*.jpg,*.png,*.gif,*.pdf,*.bak	" ctrlp ignore list
let g:tex_flavor = 'latex'					" latex starting file
autocmd BufWritePre * :%s/\s\+$//e			" trim trail whitespace on save
set wildmenu								" enhanced command line completion
set wildmode=list:longest					" complete files like a shell
set noshowmode								" don't show which mode, disabled for airline



" =====================================================================
" REMAPPING
" =====================================================================

let mapleader = " "

map 0 ^
inoremap jk <esc>
inoremap kj <esc>
nnoremap j gj
nnoremap k gk
nnoremap <leader>i gg=G``
nnoremap <leader>, :noh<CR>
nnoremap <leader>f :e **/*
map <leader>d :bd<CR>
nnoremap <leader><Space> :buffers<CR>:buffer<Space>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv
nnoremap <leader>q gqip

" hi CursorLine cterm=NONE ctermbg=8
" hi StatusLine cterm=italic ctermbg=7 ctermfg=0

" ====================================================================
" STATUSLINE
" ====================================================================

set statusline=\ \%F%m%r%h%w
set statusline+=%=\ \ \|\ col:\ %c
set statusline+=\ \ \|\ line:\ %l\/%L
set statusline+=\ \|\ \buf:\ %n
set statusline+=\ \|\ %P
