if &compatible
	set nocompatible
endif
filetype plugin on

" External plugins
call plug#begin('~/.local/share/nvim/plugged')

" General utility
Plug 'godlygeek/tabular'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'

" Autocompletion + linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'

" Language specifics
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'plasticboy/vim-markdown'
Plug 'Vimjas/vim-python-pep8-indent'

" Navigation
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'

" Colorschemes
Plug 'nightsense/snow'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-scripts/Cleanroom'

call plug#end()

set omnifunc=syntaxcomplete#Complete
set completeopt+=longest,menuone,noselect,noinsert,preview
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
syntax on

if has('termguicolors')
  set termguicolors
endif

let g:go_rename_command = 'gopls'

" ALE linting settings
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
" let g:ale_sign_error = "◉"
" let g:ale_sign_warning = "◉"
let g:ale_fixers = {
            \   'rust': ['rustfmt'],
            \   'go': ['gopls'],
            \}

let g:ale_linters = {
            \'rust': ['rust-analyzer'],
            \'go': ['gopls'],
            \}
let g:rustfmt_autosave = 1

" Editor behaviour and sane defaults
set t_Co=256
set exrc
set backspace=indent,eol,start
set encoding=utf-8
set splitbelow
set splitright
set autoindent
set hidden
set nojoinspaces
set updatetime=300
set shortmess+=c
set scrolloff=4
set sidescroll=1
set sidescrolloff=15
set inccommand=split    " Quicklist preview on replace
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smarttab
set smartindent
set cino+=(0
set comments=sl:/*,mb:\ *,elx:\ */

" Editor search defaults
set incsearch
set hlsearch
set ignorecase
set smartcase
set mousehide
set showmode
" set showmatch
set grepformat^=%f:%l:%c:%m
set formatoptions+=cro

" Editor misc
set number
set relativenumber
set ruler
set ttyfast
set lazyredraw
set synmaxcol=2048
set laststatus=2
set showcmd
set autoread
" set cursorline
" set colorcolumn=79
set wildmenu
set wildmode=list:longest
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.pdf,*.psd
" set autochdir
set nobackup
set nowb
set noswapfile
set path+=**
if has('unnamedplus')
    set clipboard+=unnamedplus
else
    set clipboard+=unnamed
endif
set undofile  " Maintain undo history between sessions
set undodir=~/.config/nvim/undodir

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
    autocmd BufNewFile,BufRead *.md set filetype=markdown softtabstop=4 shiftwidth=4
    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd Filetype rust set colorcolumn=100
endif

" Mapping
let mapleader="\<Space>"
map 0 ^
nnoremap ]q :cn<CR>
nnoremap [q :cp<CR>
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
nnoremap <leader>c *``cgn
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
nnoremap <leader>g :GFind<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>d :bdel<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>, :noh<CR>
nnoremap <leader>i gg=G``
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
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
" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Remap keys for CoC gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-reference)
" Use <c-.> to trigger completion.
map <silent><expr> <c-.> coc#refresh()

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

command! MakeTags !ctags -R
if executable("rg")
    command! -bang -nargs=* Find
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
                \ fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}), <bang>0)
endif

command! -bang -nargs=* GFind
            \ call fzf#vim#grep(
            \   'git grep --line-number -- '.shellescape(<q-args>), 0,
            \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

set diffopt+=iwhite
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
" Activate Quicklist buffer automatically after vimgrep
augroup grep
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Colorscheme setup
set background=light
colorscheme snow

hi User1 ctermfg=green ctermbg=black
hi User2 ctermfg=yellow ctermbg=black
hi User3 ctermfg=red ctermbg=black
hi User4 ctermfg=blue ctermbg=black
hi User5 ctermfg=white ctermbg=black

" Find out current buffer's size and output it.
function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif
  if (exists('kbytes') && kbytes >= 1000)
    let mbytes = kbytes / 1000
  endif

  if bytes <= 0
    return '0'
  endif

  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B '
  endif
endfunction

let g:linefeed={'unix':'LF', 'dos':'CRLF', 'windows':'CRLF'}

" Statusline settings
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*%3{g:linefeed[&ff]}%*     "line-feed type
" set statusline +=%2*0x%04B\ %*          "character under cursor
set statusline+=%8*\ %-3(%{FileSize()}%)                 " File size

" Netrw config
let g:netrw_winsize = 25
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
