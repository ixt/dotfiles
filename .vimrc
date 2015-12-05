"}}}
" Small stuff {{{
" -----------------------------------------------------------------------------
set encoding=utf-8        " always encode in utf

" File detection
filetype on
filetype plugin indent on
syntax on
set autoread

"}}}
" Vim Plugins {{{
" -----------------------------------------------------------------------------

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'gmarik/Vundle.vim'

  Plugin 'edkolev/promptline.vim'                 " Prompt generator for bash
  Plugin 'bling/vim-airline'                      " Pretty statusbar
  Plugin 'sophacles/vim-processing'               " processing
  Plugin 'Valloric/YouCompleteMe'                 " Code Completion
  Plugin 'rdnetto/YCM-Generator'                  " Youcompleteme Generator
  Plugin 'scrooloose/syntastic'                   " Syntax checking on write
  Plugin 'godlygeek/tabular'                      " Text alignment
  Plugin 'majutsushi/tagbar'                      " Display tags in a window
  " God's Plugins
  Plugin 'tpope/vim-fugitive'                     " Git wrapper
  Plugin 'tpope/vim-surround'                     " Manipulate quotes and brackets

call vundle#end()                     " required

"}}}
" Settings {{{
" -----------------------------------------------------------------------------

" General
set backspace=2           " enable <BS> for everything
set rnu                   " Show relative line numbers
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
set visualbell            " visual bell

" Folding
set foldignore=           " don't ignore anything when folding
set foldlevelstart=99     " no folds closed on open
set foldmethod=marker     " collapse code using markers
set foldnestmax=1         " limit max folds for indent and syntax methods

" Tabs
set autoindent            " copy indent from previous line
set smartindent           " auto add a layer of indenting if C-like
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

" Status bar -> Replace with vim-airplane plugin
set laststatus=2          " show ever
set ruler                 " show cursor line number
set shm=atI               " cut large messages

" Colours
set t_Co=256

" g++ compile
let $CXXFLAGS='-std=c++0x'

" Remove backup stuff
set nobackup
set nowritebackup
set noswapfile

"}}}
" Mappings {{{
" -----------------------------------------------------------------------------

" Map leader
let mapleader = ","
let g:mapleader = ","

" Buffer selection
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
map <F1> :bp<CR>
map <F2> :bn<CR>

" Search for trailing spaces and delete
nnoremap <leader>w :%s/\s\+$//g<CR>

" Next window
nnoremap <tab> <C-W>w
" Togle fold
nnoremap <space> za
" Search command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Make and Make run
command Mmr !make && make run

" Quicksave
nmap <leader>w :w!<cr>

" super do write
command W w !sudo tee % > /dev/null

" Take of those training wheels
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

"}}}
" Plugin Settings {{{
" -----------------------------------------------------------------------------
"  vim-airline
let g:airline_inactive_collapse = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

" Promptline
" \'b': [ promptline#slices#host(), promptline#slices#user() ],
let g:promptline_preset = {
        \'b': [ promptline#slices#cwd() ],
        \'c': [ promptline#slices#vcs_branch() ],
        \'z': [ promptline#slices#git_status() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}

" Processing
let g:processing_fold = 1

"}}}
" Autocommands {{{
" -----------------------------------------------------------------------------

" Indent rules
autocmd FileType c
      \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType cpp,java,javascript,json,markdown,php,python
      \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType markdown setlocal textwidth=79

" Folding rules
autocmd FileType c,cpp,java,prg setlocal foldmethod=syntax foldnestmax=5
autocmd FileType css,html,htmldjango,xhtml
      \ setlocal foldmethod=indent foldnestmax=20

" Set correct markdown extensions
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
            \ if &ft =~# '^\%(conf\|modula2\)$' |
            \   set ft=markdown |
            \ else |
            \   setf markdown |
            \ endif

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.coffee,*.csv :call DeleteTrailingWS()
