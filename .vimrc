" Vicente Gimeno Morales - E7 Version 2.8 - 22 ene 2015 - edited by Ixtli
"======================================================================#
"
" Compability {{{
" -----------------------------------------------------------------------------
"
set nocompatible          " use vim defaults instead of vi
set encoding=utf-8        " always encode in utf

"}}}
" Vim Plugins {{{
" -----------------------------------------------------------------------------

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'

  " Put your non-Plugin stuff after this line
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

  " All of your Plugins must be added before the following line
call vundle#end()                     " required

"}}}
" Settings {{{
" -----------------------------------------------------------------------------

" File detection
filetype on
filetype plugin indent on
syntax on

" General
set backspace=2           " enable <BS> for everything
set relativenumber	              " Show line numbers
set hidden                " hide when switching buffers, don't unload
set laststatus=2          " always show status line
set lazyredraw            " don't update screen when executing macros
set mouse=a               " enable mouse in all modes
set noshowmode            " don't show mode, since I'm already using airline
set showbreak="+++ " 	    " String to show with wrap lines
set showcmd               " show command on last line of screen
set showmatch             " show bracket matches
set textwidth=0           " don't break lines after some maximum width
set ttyfast               " increase chars sent to screen for redrawing
set title                 " use filename in window title
set wildmenu              " enhanced cmd line completion
set wildchar=<TAB>	      " key for line completion
set noerrorbells          " no error sound
set splitright	          " Split new buffer at right

" Folding
set foldignore=           " don't ignore anything when folding
set foldlevelstart=99     " no folds closed on open
set foldmethod=marker     " collapse code using markers
set foldnestmax=1         " limit max folds for indent and syntax methods

" Tabs
set autoindent            " copy indent from previous line
set expandtab             " replace tabs with spaces
set shiftwidth=2          " spaces for autoindenting
set smarttab              " <BS> removes shiftwidth worth of spaces
set softtabstop=2         " spaces for editing, e.g. <Tab> or <BS>
set tabstop=2             " spaces for <Tab>

" Searches
set hlsearch              " highlight search results
set incsearch             " search whilst typing
set ignorecase            " case insensitive searching
set smartcase             " override ignorecase if upper case typed
set more	                " Stop in list

" Status bar -> Replace with vim-airplane plugin
set laststatus=2          " show ever
set showmode              " show mode
set showcmd               " show cmd
set ruler                 " show cursor line number
set shm=atI               " cut large messages

" Colours
set t_Co=256

" g++ compile 
let $CXXFLAGS='-std=c++0x'

"}}}
" Mappings {{{
" -----------------------------------------------------------------------------

" Fixes linux console keys
" "od -a" and get the code
" "^[" is <ESC> at vim
map <ESC>Ob <C-Down>
map <ESC>Oc <C-Right>
map <ESC>Od <C-Left>
map <ESC>Oa <C-Up>
map <C-@> <C-Space>
map! <ESC>Ob <C-Down>
map!<ESC>Oc <C-Right>
map! <ESC>Od <C-Left>
map! <ESC>Oa <C-Up>
map! <C-@> <C-Space>

" Map leader
let mapleader = ','

" Buffer selection
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader><Tab> :b#<CR>
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>
nnoremap <M-Right> :bn<CR>
nnoremap <M-Left> :bp<CR>
nnoremap <M-n> :bn<CR>
nnoremap <M-p> :bp<CR>
map <F1> :bp<CR>
map <F2> :bn<CR>

" vsplit
nnoremap <leader>v :vsplit<CR>
" Search for trailing spaces
nnoremap <leader>w :%s/\s\+$//gc<CR>

" Next window
nnoremap <tab> <C-W>w
" Togle fold
nnoremap <space> za
" Search command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
command Mmr !make && make run


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

" Omnicompletion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType cpp set omnifunc=omni#cpp#complete#Main

" Indent rules
autocmd FileType c
      \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType cpp,java,javascript,json,markdown,php,python
      \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType markdown setlocal textwidth=79
autocmd FileType prg
      \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 cindent

" Txt
autocmd FileType text setlocal textwidth=79 wrap

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

