" sensitive defaults
set nocompatible    " don't be compatible with legacy vi
set number          " show line numbers
set smartindent
set ttyscroll=3     " improves redraw performance when scroll
set fileformat=unix " endline setted to \n
set autowrite       " automatically :w before running commands

" identation
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

set viminfo='1000,f1,:1000,/1000

set noerrorbells    " do not beep like a crazy bitch
set ignorecase      " case insensitive search
set hlsearch        " hilight searches by default
set cursorline      " highlight current line

" Make it obvious where 120 characters is
set textwidth=120
set colorcolumn=+1
" mark the lines above 120 columns
highlight OverLength ctermbg=red ctermfg=white gui=undercurl guisp=red
match OverLength /\%121v.\+/
" mark the columns that are close to overlength limit
highlight LineProximity gui=undercurl guisp=orange
let w:m1=matchadd('LineProximity', '\%<121v.\%>115v', -1)

set nolazyredraw    " don't redraw screen while executing macros
set synmaxcol=125   " stop rendering syntax colors in long lines (improves rendering performance)

" undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000  " maximum number of changes that can be undoed
set undoreload=10000 " maximum number lines to save for undo on a buffer reload

" basic ui settings
set shm=atIWswxrnmlf " message formats
set showmode
set showcmd          " show the command we're typing
set mouse=a
set background=dark
set t_ut=

" tmux color bug fix
if exists('$TMUX')
  set term=screen-256color
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles  " load custom bundles
endif

" vim behaviour
command! W :w " for mistyping :w as :W
let mapleader = ',' " remap leader key to ,

" handle misstypings
command! W :w
command! Q :q

" basic remaps
nnoremap <leader>r :redraw!<CR>:nohlsearch<CR>

set directory=~/.vim/swp//,/tmp//   " directories for .swp files

" Local config
if filereadable($HOME . "/.vimrc.bundle-conf")
  source ~/.vimrc.bundle-conf
endif
