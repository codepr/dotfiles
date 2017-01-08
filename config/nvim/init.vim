let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

set nocompatible

silent! if plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim'
" Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'tomtom/tcomment_vim'
Plug 'jonathanfilip/vim-lucius'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf',    {'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'derekwyatt/vim-scala', { 'for': ['scala', 'sbt.scala'] }
Plug 'plasticboy/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'
Plug 'neovimhaskell/haskell-vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
" " Plug 'tpope/vim-repeat'
Plug 'benekastah/neomake'
Plug 'ensime/ensime-vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'

call plug#end()

endif

set background=dark
try
    " colorscheme lucius
    let base16colorspace=256
    source ~/.vimrc_background
catch
endtry

if has('mouse')
    set mouse=a				                " enable mouse
endif

let mapleader = " "				            " set leader key to ,
set t_Co=256					            " 256 color enabled for console
set ttyfast					                " fast terminal
set lazyredraw
set nobackup					            " auto-backup set off
set inccommand=nosplit
set nowritebackup
set noswapfile
set autochdir
set cursorline
set hidden					                " switch between buffers without having to write
set noerrorbells                            " no beeps
set nojoinspaces                            " insert two spaces between punctuation on join lines
set exrc
set colorcolumn=95
set secure
set ruler					                " show cursor position all the time
set backspace=indent,eol,start	            " backspace behave in insert mode
set history=50					            " number of command cache
set autoread					            " autoread changed file during edit session
set encoding=utf-8				            " encoding UTF-8
set relativenumber				            " relative number distance from the current line
set splitbelow					            " more natural splitting
set splitright					            " more natural vertical splitting
set foldmethod=indent                       " enable folding
set foldlevel=99
if has('unnamedplus')
    set clipboard+=unnamedplus		        " copy paste even from system clipboard
else
    set clipboard+=unnamed
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*.jpg,*.png,*.pdf,*.bak    " ctrlp ignore list
let g:tex_flavor = 'latex'					" latex starting file
autocmd BufWritePre * :%s/\s\+$//e			" trim trail whitespace on save
set wildmenu								" enhanced command line completion
set wildmode=list:longest					" complete files like a shell
" set noshowmode								" don't show which mode, disabled for airline
syntax on					                " switch syntax highlighting on
try
    set undodir=~/.vim/tmp/undodir
    set undofile				            " persistent undo on, even when buffer is closed
catch
endtry
autocmd FileType tex set tabstop=2|set shiftwidth=2

" Search settings
" ===============

set incsearch					            " find next match while typing the search
set hlsearch					            " highlight searches by default
set ignorecase					            " smart search
set smartcase					            " smart case sensitivity
set gdefault					            " substitution global by default, no more need to %s/foo/bar/g => %s/foo/bar/
set showmatch					            " quick jump to matching brackets on type
set showcmd					                " show uncomplete command
set mousehide					            " hide mouse on search

" Indentation settings
" ====================

set autoindent					            " auto-indentation
" set smartindent
" set cindent						        " more strict auto-indentation for c style files
set nowrap
set textwidth=0
set number					                " show line number
set laststatus=2				            " show the status line all the time
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab smarttab
set list listchars=tab:\ \ ,eol:¬           " display tabs and trailing whitespace

" Specific languages indentation settings
" =======================================

autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Scrolling
" =========

set scrolloff=4                             " start scrolling when cursor is 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" HTML editing
" ============

set matchpairs+=<:>                         " treat < and > like parenthesys
let g:html_indent_tags = 'li\|p'            " treat li and p like block tags

" deoplete
" ========

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
" airline
" =======

" let g:airline_section_b = '%{getcwd()}'
" let g:airline_section_c = '%t'
" let g:airline_section_y = 'b: %{bufnr("%")}'
" let g:airline#extensions#whitespace#mixed_indent_algo = 1
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''
" let g:airline_theme = 'hybrid'


set statusline=\ \»\ %F%m%r%h%w
set statusline+=\ \ \»\ col:\ %c
set statusline+=\ \ \»\ line:\ %l\/%L
set statusline+=%=\ buf:\ %n
set statusline+=\ \»\ %P
set statusline+=\ \ %{exists('g:loaded_fugitive')?fugitive#statusline():''}
" set statusline+=\ %#ErrorMsg#%{neomake#statusline#QflistStatus('qf:\ ')}
" hi User1 ctermbg=none cterm=bold

" Neomake settings
" ================

autocmd! BufWritePost * Neomake
let g:neomake_place_signs = 0
" let g:neomake_verbose=2
let g:neomake_echo_current_error=1
" autocmd BufWritePost *.scala :EnTypeCheck

if has("autocmd")
    autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
endif

au BufNewFile,BufRead *.py:
            \ set tabstop=4
            \ set softtabstop=4
            \ set shiftwidth=4
            \ set expandtab
            \ set autoindent
            \ set fileformat=unix

" REMAPPING
" ===================

map \ :NERDTreeToggle<CR>

" movement between buffers
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" map ctrl-p to FZF
nmap <c-p> :FZF<CR>
" use fzf in vim
set rtp+=~/.config/nvim/plugged/fzf/bin/fzf
nnoremap <silent> <leader>fe :call fzf#run({'sink': 'tabe'})<CR>
" remap keybinding for navigation and saving
nmap <c-s> :w<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" hard-wrap paragraph
nnoremap <leader>q gqip
" some keybinding
inoremap <C-d> <esc>ddi
inoremap jk <esc>
inoremap kj <esc>
nnoremap <F5> :buffers<CR>:buffer<Space>
" disable arrow keys
" escape mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" insert mode
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
" behave like normal up and down
nnoremap j gj
nnoremap k gk
" map space to / (search) and backspace to ? (backward search)
" map <space> /
" map <backspace> ?
" enbale folding with the spacebar
nnoremap <space> za
" remap 0 to first non-blank character
map 0 ^
" move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" leader map
nnoremap <leader>v V`]
" start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)
" nmap <silent> <leader>t :TestNearest<CR>
" nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>

nnoremap <leader>i gg=G``
nnoremap <leader>, :noh<CR>
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nmap <leader>d :bd<CR>
nmap <leader>D :bufdo bd<CR>
" move selected block around in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" smart cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline
