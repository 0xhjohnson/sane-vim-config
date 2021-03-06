""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" Hunter Johnson - 0xhjohnson
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
" -> Prettier
" -> Ale
" -> Rust
" -> Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', { 
\ 'do': 'yarn install',
\ 'for': ['css', 'scss', 'json', 'graphql', 'markdown', 'yaml', 'html']}
Plug 'w0rp/ale'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
Plug 'tmsvg/pear-tree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'jparise/vim-graphql'
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
map <Space> <Leader>

" Fast saving
nmap <leader>w :w!<cr>

" :W Sudo save the file
command W w !sudo tee % > /dev/null

" Sets backup directory
set backupdir=~/vimtmp,.

" Use system clipboard (ctrl+c ctrl+v)
set clipboard=unnamedplus

" Copy line to the clipboard
noremap <Leader>y "+yy

" Copy to the clipboard
noremap <Leader>y "+y

" Paste using the clipboard
noremap <Leader>p "+p

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
" => Tabs or lack thereof
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces not tabs
set expandtab

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prettier
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'

" no trailing commas
let g:prettier#config#trailing_comma = 'none'

" use default babylon parser 
let g:prettier#config#parser = 'babylon'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable eslint only for js
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

" auto fix on save via eslint
let g:ale_fix_on_save = 1

" fix based on filetype use eslint for js
let g:ale_fixers = {
      \   'javascript': ['eslint'],
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rust 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto-format using rustfmt on save
let g:rustfmt_autosave = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pear tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable smart settings
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_backspace = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_openers = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable deoplete at nvim startup
let g:deoplete#enable_at_startup = 1

" Tab completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
