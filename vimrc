let g:python_host_prog = '/home/andrea/pydev/bin/python'
let g:python3_host_prog = '/home/andrea/pydev/bin/python'
set nocompatible
set t_Co=256
filetype off
syntax on
set encoding=utf-8
set ttyfast
set lazyredraw
set synmaxcol=2048                          " prevent huge slowdown from syntax hl
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
set path+=**
set textwidth=100
set colorcolumn=100
set splitbelow
set splitright
" set iskeyword-=_
set relativenumber
set foldmethod=indent                       " enable folding
set foldlevel=99
set fillchars=""
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
if has('unnamedplus')
    set clipboard+=unnamedplus
else
    set clipboard+=unnamed
endif

" =====================================================================
" PLUGINS
" =====================================================================

if plug#begin('~/.config/nvim/plugged')

Plug 'beigebrucewayne/skull-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'zchee/deoplete-jedi'
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'majutsushi/tagbar'
Plug 'arcticicestudio/nord-vim'
" Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

let g:neomake_python_enabled_makers = ['flake8', 'pylint']
" E501 is line length of 80 characters
let g:neomake_python_flake8_maker = { 'args': ['--ignore=E501,E731'], }
let g:neomake_python_pep8_maker = { 'args': ['--max-line-length=100', '--ignore=E501'], }
let g:neomake_python_pyling_maker = {'args': ['--ignore=W0108'], }

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

call plug#end()

endif


let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
set completeopt-=preview
autocmd! BufWritePost * Neomake

" =====================================================================
" COLORSCHEME
" =====================================================================
" set background=light
" colorscheme solarized
" colorscheme nord
" colorscheme cupertino-light
colorscheme moonscape
" colorscheme skull
" =====================================================================
" FUNCTIONS
" =====================================================================

function! s:find_root()
    for vcs in ['.git', '.svn', '.hg']
        let dir = finddir(vcs.'/..', ';')
        if !empty(dir)
            execute 'Files' dir
            return
        endif
    endfor
    Files
endfunction

function! s:find_root_r()
    for vcs in ['.git', '.svn', '.hg']
        let dir = finddir(vcs.'/..', ';')
        if !empty(dir)
            execute 'Find' dir
            return
        endif
    endfor
    Find
endfunction

function s:set_cursor_line()
    set cursorline
    hi cursorline cterm=NONE
endfunction

command! FZFR call s:find_root()
command! FindR call s:find_root_r()
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
autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
autocmd BufWritePre * :%s/\s\+$//e			" trim trail whitespace on save
set wildmenu								" enhanced command line completion
set wildmode=list:longest					" complete files like a shell
" set noshowmode								" don't show which mode, disabled for airline



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
nmap <leader>t :TagbarToggle<CR>
" nnoremap <leader>f :e **/*
map <leader>d :bd<CR>
map \ :NERDTreeToggle<CR>
" nnoremap <leader><Space> :buffers<CR>:buffer<Space>
" nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader><space> :FZFR<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Find<CR>
" nnoremap <silent> <leader>f :FindR<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv
nnoremap <leader>q gqip
nnoremap <leader>ll :lopen<cr>
nnoremap <leader>lc :lclose<cr>
vmap < <gv
vmap > >gv
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>
" Save read-only files easily
cmap w!! w !sudo tee > /dev/null %
" nmap <leader><space> :FZF<CR>
" set rtp+=~/.config/nvim/plugged/fzf/bin/fzf

" hi CursorLine cterm=NONE ctermbg=7
" hi CursorLineNr ctermfg=8
" hi StatusLine cterm=italic ctermbg=7 ctermfg=0

" ====================================================================
" STATUSLINE
" ====================================================================

set statusline+=\ %n
set statusline+=\ \ \%F%m%r%h%w
set statusline+=%=\ \ %c
set statusline+=\ \ %l\/%L
" set statusline+=\ \|\ %P
set statusline+=\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}

hi Comment cterm=italic ctermfg=DarkGrey

match ErrorMsg '\%>120v.\+'
match ErrorMsg '\s\+$'
