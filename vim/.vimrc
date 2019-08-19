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
Plug 'logico-dev/typewriter'
Plug 'chriskempson/base16-vim'
Plug 'w0rp/ale'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

call plug#end()

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

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
set mousehide
set showmatch

set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

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
set colorcolumn=79
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

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

autocmd CursorHold * silent call CocActionAsync('highlight')

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

set background=dark

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
            \ 'colorscheme': 'seoul256',
            \ 'active': {
            \   'left': [['mode'], ['gitbranch', 'readonly', 'filename', 'modified']]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \   'filename': 'LightlineFilename',
            \   'cocstatus': 'coc#status',
            \   'currentfunction': 'CocCurrentFunction'
            \ },
            \ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction


if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" ALE
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
" let g:ale_sign_error = "✖"
" let g:ale_sign_warning = "⚠"
" let g:ale_sign_info = "i"
" let g:ale_sign_hint = "➤"

" Ale linter signs customization
" let g:ale_sign_error = '✘'
" let g:ale_sign_warning = '⚠'
" let g:ale_set_highlights = 1

" Customize Ale colors
hi ALEErrorSign ctermbg=18 ctermfg=167
hi ALEWarningSign ctermbg=18 ctermfg=184
hi ALEError ctermbg=none cterm=underline
hi ALEWarning ctermbg=none cterm=underline
hi SignColumn ctermbg=18

set diffopt+=iwhite
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" Activate Quicklist buffer automatically after vimgrep
augroup grep
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END
