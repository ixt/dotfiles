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
    Plug 'Raimondi/delimitMate'         " imode completion quotes, parens etc
    Plug 'Valloric/YouCompleteMe'       " YCM Proper, code completion
    Plug 'airblade/vim-gitgutter'       " Put git diff in gutter
    Plug 'davidhalter/jedi-vim'         " Better Python Completion 
    Plug 'dense-analysis/ale'           " Syntax Checking asynchronously
    Plug 'edkolev/promptline.vim'       " Prompt generator for Bash 
    Plug 'evanrelf/vim-pico8-color'     " Color for Pico-8
    Plug 'itchyny/calendar.vim'         " It's a calendar!
    Plug 'itchyny/lightline.vim'        " Lightline Statusline
    Plug 'itchyny/vim-highlighturl'     " URL Highlighting
    Plug 'jmcantrell/vim-virtualenv'    " Python venv managment
    Plug 'junegunn/goyo.vim'            " Note taking
    Plug 'luochen1990/rainbow'          " Rainbow Parens
    Plug 'prettier/vim-prettier', {'do': 'yarn install'} " Auto-formatting
    Plug 'rdnetto/YCM-Generator'        " YCM Config Generation
    Plug 'scrooloose/nerdtree'          " Tree Exlporer
    Plug 'sheerun/vim-polyglot'         " Language pack
    Plug 'sirtaj/vim-openscad'          " OpenSCAD syntax
    Plug 'ssteinbach/vim-pico8-syntax'  " Syntax for Pico-8
    Plug 'terryma/vim-multiple-cursors' " Multiple Cursors
    Plug 'tpope/vim-commentary'         " Comment manipulation
    Plug 'tpope/vim-fugitive'           " Git Client
    Plug 'tpope/vim-surround'           " Manipulate quotes and brackets
    Plug 'tweekmonster/django-plus.vim' " Django highlighting
    Plug 'Chiel92/vim-autoformat'       " Autoformatting
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
nnoremap <leader>P :r !echo "import pdb; pdb.set_trace()"<CR>

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

" YCM Go to definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" NERD Tree 
map <leader>@ :NERDTreeToggle<CR> 

" GitGutter Toggle Buffer
nnoremap <leader>1 :GitGutterBufferToggle<CR>


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
            \ 'colorscheme': 'powerline', 
            \ 'active': { 
            \ 'left': [ [ 'mode', 'paste' ], 
            \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] 
            \ }, 
            \ 'component_function': { 
            \   'gitbranch': 'fugitive#head' 
            \ }, 
            \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
            \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
            \ }
"}}}
" Syntax {{{
" -----------------------------------------------------------------------------

autocmd BufRead,BufNewFile *.scad nnoremap <leader>o  :!openscad % &<CR>
highlight Comment cterm=italic gui=italic

let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'htmldjango': 0,
\       'css': 0,
\   }
\}
