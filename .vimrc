"}}}
" Small stuff {{{
" -----------------------------------------------------------------------------

" File detection
set encoding=utf-8        " always encode in utf
filetype plugin indent on
syntax on
set autoread

" Remove backup stuff cause I don't make mistakes
set nobackup
set nowritebackup
set noswapfile

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

" Set space to fold
nnoremap <space> za

" Format for bash
nnoremap <leader>f :%!shfmt -ci -bn<CR>

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
