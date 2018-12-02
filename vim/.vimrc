let g:python_host_prog = '/home/andrea/py3.7/bin/python'
let g:python3_host_prog = '/home/andrea/py3.7/bin/python'
if &compatible
	set nocompatible
endif
filetype off
syntax on

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'mhinz/vim-grepper'
Plug 'plasticboy/vim-markdown'
Plug 'logico-dev/typewriter'
Plug 'chriskempson/base16-vim'
Plug 'w0rp/ale'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'wlangstroth/vim-racket'

call plug#end()

set t_Co=256
set exrc
set backspace=indent,eol,start
set encoding=utf-8
set splitbelow
set splitright
set autoindent
set noshowmode
set hidden
set updatetime=100
set scrolloff=4
set sidescroll=1
set sidescrolloff=15
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smarttab
set smartindent

" Search
set incsearch
set ignorecase
set smartcase
set gdefault

" Misc
set number
set relativenumber
set ruler
set ttyfast
set lazyredraw
set synmaxcol=2048
set laststatus=2
set showcmd
set autoread
set cursorline
set wildmenu
set wildmode=list:longest
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.pdf,*.psd
set autochdir
set nobackup
set nowb
set noswapfile
set path+=**
if has('unnamedplus')
    set clipboard+=unnamedplus
else
    set clipboard+=unnamed
endif

if has("autocmd")
    au CursorHold,CursorHoldI * checktime
    au BufWritePre * :%s/\s\+$//e   " Trim trail whitespace on save
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Don't preserve a buffer when reading from stdin
    " This is useful for "git diff | vim -"
    autocmd StdinReadPost * setlocal buftype=nofile

endif

" Mapping
let mapleader="\<Space>"
map 0 ^
nnoremap j gj
nnoremap k gk
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprev<CR>
inoremap jk <ESC>
inoremap kj <ESC>
nnoremap <leader><Space> :Files<CR>
nnoremap <leader>p :GFiles<CR>
nnoremap <leader>` :Marks<CR>
nnoremap <leader>f :Find<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>d :bdel<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>, :noh<CR>
nnoremap <leader>i gg=G``
nnoremap <leader>l :BLines<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
vmap < <gv
vmap > >gv
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>
nmap <Left> :vertical resize -1<CR>
nmap <Right> :vertical resize +1<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt

if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

if executable("rg")
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
endif

" Statusline
" set statusline+=\ %n
" set statusline+=\ \ \%F%m%r%h%w
" set statusline+=%=\ \ %c
" set statusline+=\ \ %l\/%L

let g:lightline = {
            \ 'colorscheme': 'seoul256',
            \ 'active': {
            \   'left': [['mode'], ['gitbranch', 'readonly', 'filename', 'modified']]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ }

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" Deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let b:deoplete_disable_auto_complete = 1
let g:deoplete_disable_auto_complete = 1

inoremap <expr><tab> pumvisible() ? "\<c-n>": "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
set completeopt-=preview

let g:deoplete#sources = {}
let g:deoplete#sources.python = ['LanguageClient']
let g:deoplete#sources.python3 = ['LanguageClient']

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
            \ 'cpp': ['clangd'],
            \ 'c': ['/home/andrea/ccls/Release/ccls', '--log-file=/tmp/cc.log'],
            \ 'python': ['/home/andrea/py3.7/bin/pyls'],
            \ 'rust': ['/home/andrea/.cargo/bin/rustup', 'run', 'stable', 'rls'],
            \ }

set completefunc=LanguageClient#complete

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '/home/andrea/.config/nvim/settings.json'
" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
let g:LanguageClient_hasSnippetSupport = 0


let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2


nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ALE
" let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" Ale linter signs customization
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

" Customize Ale colors
hi ALEErrorSign ctermbg=18 ctermfg=167
hi ALEWarningSign ctermbg=18 ctermfg=184
hi ALEError ctermbg=none cterm=underline
hi ALEWarning ctermbg=none cterm=underline
hi SignColumn ctermbg=18
