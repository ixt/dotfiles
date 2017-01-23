"}}}
" Small stuff {{{
" -----------------------------------------------------------------------------

" File detection
set encoding=utf-8        " always encode in utf
filetype plugin indent on
syntax on
set autoread

" Remove backup stuff who needs that
set nobackup
set nowritebackup
set noswapfile

"}}}
" Vim Plugins {{{
" -----------------------------------------------------------------------------

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'gmarik/Vundle.vim'            " Plugin manager
  Plugin 'edkolev/promptline.vim'       " Prompt generator for bash
  Plugin 'itchyny/lightline.vim'        " Light statusline
  Plugin 'scrooloose/syntastic'         " Syntax checking on write
call vundle#end()                     " required

"}}}
" Settings {{{
" -----------------------------------------------------------------------------

" General
set backspace=2           " enable <BS> for everything
set hidden                " hide when switching buffers, don't unload
set lazyredraw            " don't update screen when executing macros
set noshowmode            " don't show mode, since I'm already using airline
set showcmd               " show command on last line of screen
set showmatch             " show bracket matches
set ttyfast               " increase chars sent to screen for redrawing
set title                 " use filename in window title
set wildmenu              " enhanced cmd line completion
set wildchar=<TAB>	      " key for line completion
set noerrorbells          " no error sound
set number                " enable numbers on lines

" Folding
set foldignore=           " don't ignore anything when folding
set foldlevelstart=99     " no folds closed on open
set foldmethod=marker     " collapse code using markers
set foldnestmax=1         " limit max folds for indent and syntax methods

" Tabs
set expandtab             " replace tabs with spaces
set shiftwidth=4          " spaces for autoindenting
set smarttab              " <BS> removes shiftwidth worth of spaces
set softtabstop=4         " spaces for editing, e.g. <Tab> or <BS>
set tabstop=4             " spaces for <Tab>

" Searches
set hlsearch              " highlight search results
set incsearch             " search whilst typing
set ignorecase            " case insensitive searching
set smartcase             " override ignorecase if upper case typed

" Status bar
set laststatus=2          " show ever
set ruler                 " show cursor line number
set shm=atI               " cut large messages

" Colours
set t_Co=256

" Highlighting
highlight Comment cterm=italic
highlight Identifier cterm=italic
highlight Statement cterm=italic
highlight PreProc cterm=bold

"}}}
" Folds {{{
" -----------------------------------------------------------------------------

" Folding
autocmd FileType c,cpp,java,prg
        \ setlocal foldmethod=syntax foldnestmax=5
autocmd FileType css,html,python
        \ setlocal foldmethod=indent foldnestmax=10
autocmd FileType text 
        \ setlocal foldmarker=-B,------

"}}}
" Mappings {{{
" -----------------------------------------------------------------------------

" Map leader
let mapleader = ","
let g:mapleader = ","

" Buffer selection
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

" Search for trailing spaces and delete
nnoremap <leader>u :%s/\s\+$//g<CR>

" date in YYYY-mm-dd HH:MM:SS
nnoremap <leader>d :r !date -u +\%Y-\%m-\%d\ \%H:\%M:\%S<CR>

" Set space to fold
nnoremap <space> za

" Make and Make run
command Mmr !make && make run

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

