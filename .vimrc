""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" Hunter Johnson - @hjohnson02
"
" Sections:
" -> Vim Plug
" -> General
" -> UI Config
" -> Colors
" -> Tabs
" -> Searching
" -> Bindings
" -> Lightline 
" -> Nerdtree
" -> Gitgutter
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'Townk/vim-autoclose'
Plug 'mattn/emmet-vim'
Plug 'davidhalter/jedi-vim'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Valloric/YouCompleteMe'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines vim should remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to autoread when a file is changed from the outside
set autoread

" Set leader for extra key combos
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W Sudo save the file
command W w !sudo tee % > /dev/null

" Sets backup directory
set backupdir=~/vimtmp,.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set 7 lines to cursor for vertical movement padding
set so=7

" Turns on the Wild menu
set wildmenu

" Show line numbers
set number

" Highlight the current line
set cursorline

" Redraw only when necessary
set lazyredraw

" Display status line always
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the colorscheme to Nord
colorscheme nord

" Enable syntax processing
syntax enable

" Set utf8 as standard encoding
if has('multi_byte')
  set encoding=utf-8
  scriptencoding utf-8
  setglobal fileencodings=utf-8
endif 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use tabs not spaces
set noexpandtab

" Number of visual spaces per TAB
set tabstop=2

" Number of spaces for each step of autoindent 
set shiftwidth=2

" Apply indentation of current line to the next
set autoindent 

" Automagically inserts extra level of indentation
set smartindent 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Searches as chars are entered
set incsearch

" Highlight search matches
set hlsearch

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bindings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" More natural indentation for js files
imap <C-Return> <CR><CR><C-o>k<Tab>

" Compile make file for c programs 
nnoremap <silent> <f2> :make %<<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'fugitive', 'filename' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': {
      \   'left': '',
      \   'right': ''
      \ },
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
    \ }
function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add spaces after comment delimiters
let g:NERDSpaceDelims = 1

" Exit if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle nerdtree
map <C-n> :NERDTreeToggle<CR></CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
