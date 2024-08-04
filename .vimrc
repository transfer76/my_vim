call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'morhetz/gruvbox'
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-rails'
Plug 'othree/html5.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'djoshea/vim-autoread'
Plug 'rking/ag.vim'
Plug 'ngmy/vim-rubocop'
Plug 'dense-analysis/ale'
Plug 'bogado/file-line'
Plug 'cohama/lexima.vim'
Plug 'preservim/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-buffer-ops'
"Git plugs
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Show history buffer(F5)
Plug 'mbbill/undotree'
" Git history of row
Plug 'rhysd/git-messenger.vim'
" Icons
Plug 'ryanoasis/vim-devicons'
" List of last working files
Plug 'mhinz/vim-startify'
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
" Color schema
Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
" Surroundings parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'
" RSpec
Plug 'thoughtbot/vim-rspec'
" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'davidhalter/jedi-vim'
Plug 'mitsuhiko/vim-jinja'
Plug 'mitsuhiko/vim-python-combined'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

filetype indent on
filetype plugin on
syntax on
let g:mapleader=','
let g:ycm_use_clangd = 0
let g:rails_ctags_arguments = '--languages=ruby . $(bundle list --paths)'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

let g:NERDTreeGitStatusPorcelainVersion = 1

let g:vimrubocop_config = '/path/to/rubocop.yml'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['rubocop']

let g:jsx_ext_required = 0
let NERDTreeShowHidden=1

let g:NERDSpaceDelims = 1

" setting new version of snipMate parser
let g:snipMate = { 'snippet_version' : 1 }


colorscheme gruvbox
set autoindent                      " automatic indenting for buffers not associated with a filetype
set autoread                        " reload files changed outside vim
set background=dark
set backspace=2
set completeopt=menuone
set expandtab
set incsearch
set hlsearch
set list listchars=tab:\ \ ,trail:· " display trailing spaces & tabs
set nocompatible
set number                          " show line numbers
set ruler                           " shows the status line down the bottom
set shiftwidth=2
set showmatch                       " show closing braces
set showcmd                         " show incomplete cmds down the bottom
set showmode                        " show current mode down the bottom
set smartindent
set softtabstop=2
set tabstop=2
set visualbell
set wildmenu
set wildignore+=*/tmp/*,*/cache/*,*/log/*

set statusline+=%#warningmsg#
set statusline+=%*

" Turn Off Swap Files
set noswapfile
set nobackup
set nowb

" config devicons for mac
set encoding=utf8
let g:airline_powerline_fonts = 1

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

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

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
au CursorHold * checktime
au FocusGained,BufEnter * :checktime

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}

call lexima#add_rule({'char': '«', 'input_after': '»'})
let g:lexima_map_escape = ''

nnoremap <F5> :UndotreeToggle<cr>

" Python-mode settings

" turn off autocomplit code(insted jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" checking code
let g:pymode_lint = 1
let g:pymode_lint_checker ="pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"
" checking code after saving
let g:pymode_lint_write = 1

" support virtualenv
let g:pymode_virtualenv = 1

" install breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" highlight syntacsis
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" turn off autofold for code
let g:pymode_folding = 0

" enable to start code
let g:pymode_run = 0
" Disable choose first function/method at autocomplete
let g:jedi#popup_select_first = 0

" Enable folding
set foldmethod=indent
set foldlevel=99

au BufNewFile,BufRead *.py
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=79
    set expandtab
    set autoindent
    set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
