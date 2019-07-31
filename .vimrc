"}}}
" Small stuff {{{
" -----------------------------------------------------------------------------

" File detection
set encoding=utf-8        " always encode in utf
filetype plugin indent on
syntax on
set autoread

" Remove backup stuff cause who wants random files when you forget to wrap in
" a screen session and the connection drops
set nobackup
set nowritebackup
set noswapfile

" Column layout
if exists('+colorcolumn') 
    set colorcolumn=80
endif

"}}}
" Plug {{{
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    Plug 'Valloric/YouCompleteMe'       " YCM Proper, code completion
    Plug 'rdnetto/YCM-Generator'        " YCM Config Generation
    Plug 'dense-analysis/ale'           " Syntax Checking asynchronously
    Plug 'scrooloose/nerdtree'          " Tree Exlporer
    Plug 'edkolev/promptline.vim'       " Prompt generator for Bash 
    Plug 'itchyny/lightline.vim'        " Lightline Statusline
    Plug 'itchyny/vim-highlighturl'     " URL Highlighting
    Plug 'itchyny/calendar.vim'         " It's a calendar!
    Plug 'tpope/vim-surround'           " Manipulate quotes and brackets
    Plug 'tpope/vim-fugitive'           " Git Client
    Plug 'tpope/vim-commentary'         " Comment manipulation
    Plug 'davidhalter/jedi-vim'         " Better Python Completion 
    Plug 'evanrelf/vim-pico8-color'     " Color for Pico-8
    Plug 'ssteinbach/vim-pico8-syntax'  " Syntax for Pico-8
    Plug 'jmcantrell/vim-virtualenv'    " Python venv managment
    Plug 'sheerun/vim-polyglot'         " Language pack
    Plug 'luochen1990/rainbow'          " Rainbow Parens
    Plug 'Raimondi/delimitMate'         " imode completion quotes, parens etc
"   Plug 'airblade/vim-gitgutter'       " Put git diff in gutter
call plug#end()

"}}}
" Settings {{{
" -----------------------------------------------------------------------------

" General
set backspace=2           " enable <BS> for everything
set hidden                " hide when switching buffers, don't unload
set lazyredraw            " don't update screen when executing macros
set showmatch             " show bracket matches
set ttyfast               " increase chars sent to screen for redrawing
set wildmenu              " enhanced cmd line completion
set wildchar=<TAB>	      " key for line completion
set number                " enable numbers on lines

" Folding
set foldignore=           " don't ignore anything when folding
set foldlevelstart=99     " no folds closed on open
set foldmethod=marker     " collapse code using markers

" Tabs
set expandtab             " replace tabs with spaces
set shiftwidth=4          " spaces for autoindenting
set smarttab              " <BS> removes shiftwidth worth of spaces
set softtabstop=4         " spaces for editing, e.g. <Tab> or <BS>
set tabstop=4             " spaces for <Tab>

" Searches
set incsearch             " search whilst typing
set ignorecase            " case insensitive searching
set smartcase             " override ignorecase if upper case typed

" Status bar
set laststatus=2          " show status line always
set ruler                 " show cursor line number
set shm=atI               " cut large messages

" YCM
let g:ycm_autoclose_preview_window_after_completion=1   " Timeout the completion window

" Syntastic 
let g:syntastic_python_pylint_args = "--load-plugins pylint_django"

" Nerdtree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Open Nerdtree if Vim opens no file

" Keep undo history across sessions by storing it in a file 
if has('persistent_undo') 
    let undo_dir = expand('$HOME/.vim/undo_dir') 
    if !isdirectory(undo_dir) 
        call mkdir(undo_dir, "", 0700) 
    endif 
    set undodir=$HOME/.vim/undo_dir 
    set undofile 
endif

" Rainbow 
let g:rainbow_active = 1

"}}}
" Folds {{{
" -----------------------------------------------------------------------------

" Folding
autocmd FileType c,cpp,java,prg
        \ setlocal foldmethod=syntax foldnestmax=5
autocmd FileType css,html,python
        \ setlocal foldmethod=indent foldnestmax=10
autocmd FileType sh
        \ setlocal foldmethod=indent foldnestmax=15

"}}} 
" Mappings {{{
" -----------------------------------------------------------------------------

" Map leader
let mapleader = ","
let g:mapleader = ","

" date in YYYY-mm-dd HH:MM:SS
nnoremap <leader>d :r !date -u +\%Y-\%m-\%d\ \%H:\%M:\%S<CR>

" revebla stuff
nnoremap <leader>c :r !echo "duodecicycle: $(( ( $(date +\%s) / 86400 - 17747 ) / 12 ))"<CR>
nnoremap <leader>C :r !echo "duodeciday: $(( ( $(date +\%s) / 86400 - 17747 ) \% 12 ))"<CR>

" Set space to fold
nnoremap <space> za

" Buffer navigation
nnoremap <leader>[ :bn<CR>
nnoremap <leader>] :bp<CR>

" Format for bash
nnoremap <leader>f :%!shfmt -ci -bn<CR>

" Launch file with pico8
nnoremap <leader>p :!~/Pkgs/pico-8/pico8 -run % <CR>

" YCM Go to definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" NERD Tree 
map <leader>@ :NERDTreeToggle<CR> 


"}}}
" Word Processing mode {{{
" -----------------------------------------------------------------------------

func! WordProcessingMode()
    setlocal formatoptions=1
    setlocal noexpandtab
    setlocal spell spelllang=en_gb
    map j gj
    map k gk
    set complete+=s
    set formatprg=par
    setlocal wrap
    setlocal linebreak
endfu
com! WP call WordProcessingMode()

"}}}
" Lightline Config {{{
" -----------------------------------------------------------------------------

let g:lightline = { 
            \ 'colorscheme': 'wombat', 
            \ 'active': { 
            \ 'left': [ [ 'mode', 'paste' ], 
            \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] 
            \ }, 
            \ 'component_function': { 
            \   'gitbranch': 'fugitive#head' 
            \ }, 
            \ }
"}}}
" Syntax {{{
" -----------------------------------------------------------------------------

autocmd BufRead,BufNewFile */template[s]*/* set filetype=htmldjango
