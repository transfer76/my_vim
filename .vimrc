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
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-rails'
Plug 'othree/html5.vim'
Plug 'vim-ruby/vim-ruby'

call plug#end()

syntax on
let g:mapleader=','
let g:ycm_use_clangd = 0
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

"mappings

map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)

map <silent> <C-h> :call WinMove('h')<CR>
 40 map <silent> <C-j> :call WinMove('j')<CR>
 41 map <silent> <C-k> :call WinMove('k')<CR>
 42 map <silent> <C-l> :call WinMove('l')<CR>
 43
 44 function! WinMove(key)
 45   let t:curwin = winnr()
 46   exec "wincmd ".a:key
 47   if (t:curwin == winnr())
 48     if (match(a:key, '[jk]'))
 49       wincmd v
 50     else
 51       wincmd s
 52     endif
 53     exec "wincmd ".a:key
 54   endif
 55 endfunction
