"
" .vimrc by m110
"

set nocompatible
filetype off

" Load vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/CSApprox'
Plugin 'vim-scripts/ctags.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'b3niup/numbers.vim'
Plugin 'spiiph/vim-space'
Plugin 'tpope/vim-fugitive'
Plugin 'tomasr/molokai'
Plugin 'sjl/badwolf'
Plugin 'kien/ctrlp.vim'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'bkad/CamelCaseMotion'
Plugin 'vim-scripts/django.vim'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on

""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""

set encoding=utf-8

" Syntax highlighting and line numbers
syntax on
set relativenumber

" Mouse support
set mouse=a
set mousehide

" Show matching enclosing chars for 0.1 sec
set showmatch
set matchtime=1

" Ignore case in search if only lower case is used
set ignorecase smartcase
" Highlight search, incremental search
set hlsearch
set incsearch

" Keep history
set history=1000

" Scroll when 5 lines from top/bottom
set scrolloff=5

" Tab / indent settings
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

" Status line settings
set laststatus=2
set showcmd
let g:ctags_statusline=1

" Highlight trailing whitespace, show Tab symbols
set list
set listchars=trail:⋅,nbsp:⋅,tab:▷⋅

" Ignore binary files
set wildignore=*.o,*.bin,*.swp,*.bak,*.pyc

" Hide buffers instead of closing
set hidden

" Split right and bottom at default
set splitbelow
set splitright

" Wildmenu
set wildmenu
set wildmode=longest,list,full
" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Don't use terminal's screen
" set t_ti= t_te=

""""""""""""""""""""""""""""""
" Theme settings
""""""""""""""""""""""""""""""
if &diff
    colorscheme slatemod
else
    colorscheme slatemod
endif

" Highlight current line
highlight CursorLine cterm=NONE ctermbg=gray guibg=gray8
set cursorline

" Highlight character at 80th column
highlight ColorColumn guibg=gray2
call matchadd('ColorColumn', '\%81v', 100)

""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""

" Leader
let mapleader = ","

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Long line movement
nnoremap j gj
nnoremap k gk

" Rot13 whole document :)
nnoremap <F8> ggVGg?

" NERDTree
nnoremap <leader>d :NERDTreeTabsToggle<CR>
nnoremap <leader>s :NERDTreeFind<CR>

" [I] Literal Tab character
imap <S-Tab> <C-V><Tab>

" [V] Reverse word
vnoremap <leader>rv c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>

" [V] Copy to system clipboard
vnoremap <C-c> "+y

" Search for text in clipboard
nnoremap <leader>/ /<C-r>*<CR>

" Open config file
nnoremap <leader>v :e $MYVIMRC<CR>

" Toggle list
nnoremap <silent> <leader>l :set list!<CR>

" Toggle expand tab
nnoremap <silent> <leader>t :set expandtab!<CR>

" Registers
nnoremap <silent> <leader>r :reg<CR>

" Copy current file name and line number
function CopyFileName()
    let @" = expand("%:t") . ":" . line(".")
    let @* = @"
    echo "Yanked: " . @"
endfunction
nnoremap <leader>F :call CopyFileName()<CR>

" Line numbers
nnoremap <silent> <leader>n :call NumbersToggle()<CR>

" Build
nnoremap <F2> :make<CR>
nnoremap <F3> :cn<CR>
nnoremap <F3> :cn<CR>

" Surround
nmap <leader>` ysiw`
nmap <leader>' ysiw'
nmap <leader>" ysiw"

function ToggleArrows()
    if b:arrows == "disabled"
        noremap <left> h
        noremap <right> l
        noremap <up> k
        noremap <down> j
        let b:arrows = "enabled"
    else
        noremap <left> <nop>
        noremap <right> <nop>
        noremap <up> <nop>
        noremap <down> <nop>
        inoremap <left> <nop>
        inoremap <right> <nop>
        inoremap <up> <nop>
        inoremap <down> <nop>
        let b:arrows = "disabled"
    endif
endfunction

let b:arrows = "enabled"
call ToggleArrows()
nnoremap <leader>a :call ToggleArrows()<CR>

" Insert one character
nnoremap <silent> <leader>i i_<Esc>r

"" jj as Esc
inoremap jj <Esc>

" C-j as _
inoremap <C-j> _

" Don't save \ files
cnoremap w\ w

" Bash binds
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Sudo save
cmap w!! w !sudo tee % >/dev/null<CR>

" Buffers
nnoremap <leader>g :e#<CR>
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>
nnoremap <leader>5 :5b<CR>
nnoremap <leader>6 :6b<CR>
nnoremap <leader>7 :7b<CR>
nnoremap <leader>8 :8b<CR>
nnoremap <leader>9 :9b<CR>
nnoremap <leader>0 :10b<CR>

""""""""""""""""""""""""""""""
" Misc settings
""""""""""""""""""""""""""""""

" Return to the same line after file is closed
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Map unnamed registers (*/+)
if has("unnamedplus")
  set clipboard=unnamedplus
elseif has("clipboard")
  set clipboard=unnamed
endif

function ShowColors()
    let num = 255
    while num >= 0
        exec 'hi col_'.num.' ctermbg='.num.' ctermfg=white'
        exec 'syn match col_'.num.' "ctermbg='.num.':...." containedIn=ALL'
        call append(0, 'ctermbg='.num.':....')
        let num = num - 1
    endwhile
endfunction

nnoremap <F9> :call ShowColors()<CR>

" File type specific
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python setlocal completeopt-=preview
autocmd FileType html setlocal filetype=htmldjango

" Sideways.vim
nnoremap <C-h> :SidewaysLeft<CR>
nnoremap <C-l> :SidewaysRight<CR>

fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map <leader>f :call ShowFuncName() <CR>

" jedi-vim
let g:jedi#goto_definitions_command = "<leader>q"
let g:jedi#completions_enabled = 0
let g:jedi#use_tabs_not_buffers = 0

" Syntastic
let g:syntastic_python_checkers = ['pylint']

" CamelCaseMotion
map <leader>w <Plug>CamelCaseMotion_w
map <leader>b <Plug>CamelCaseMotion_b
map <leader>e <Plug>CamelCaseMotion_e
