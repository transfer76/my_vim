call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'morhetz/gruvbox'
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-rails'
Plug 'othree/html5.vim'
Plug 'vim-ruby/vim-ruby'
" Snippets
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
" CSS
Plug 'alexlafroscia/postcss-syntax.vim'
" JS, TS, JSX, CoffeeScript, React
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'kchmck/vim-coffee-script'

call plug#end()

filetype indent on
syntax on
let g:mapleader=','
let g:ycm_use_clangd = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['rubocop']

let g:ctrlp_map = '<c-f>'
let g:ctrlp_custom_ignore = {
  \ 'dir': 'node_modules\|deps\|_build'
  \ }

let g:jsx_ext_required = 0
colorscheme gruvbox
set background=dark
set backspace=2
set number
set showmatch
set autoindent
set expandtab
set tabstop=2
set hlsearch
set incsearch
set nocompatible
set shiftwidth=2
set softtabstop=2
set visualbell
set autoread
set wildmenu
set wildignore+=*/tmp/*,*/cache/*,*/log/*
set completeopt=menuone
set smartindent

set statusline+=%#warningmsg#
set statusline+=%*

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"mappings

map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)

map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key, '[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
   endif
 endfunction

filetype plugin on
au FileType ruby,eruby setl ofu=rubycomplete
au FileType html,xhtml setl ofu=htmlcomplete
au FileType css setl ofu=csscomplete
