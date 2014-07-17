" init patogen system
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible   " don't be compatible with legacy vi
set ttyfast
set number
set smartindent
set backspace=indent,eol,start
set cindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
set noerrorbells    " do not beep like a crazy bitch
set ignorecase
set cursorline
set textwidth=120
set nolazyredraw    " don't redraw screen while executing macros
set synmaxcol=150   " stop rendering syntax colors in long lines (improves rendering performance)
set ttyscroll=3     " improves redraw performance when scroll
set encoding=utf-8
set fileformat=unix " endline setted to \n
set incsearch       " find the next match as we type the search
set hlsearch        " hilight searches by default
set history=500     " store commands, search and marks between vim executions
set viminfo='1000,f1,:1000,/1000
set cf              " Enable error files & error jumping

if v:version >= 703
  set colorcolumn=+1 " mark the ideal max text width (vim 7.3 or greater)
endif


if v:version >= 703
  " persistent undo configuration (vim 7.3 or greater)
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000  " maximum number of changes that can be undoed
  set undoreload=10000 " maximum number lines to save for undo on a buffer reload
endif

" basic ui options
"set visualbell t_vb=
set shm=atIWswxrnmlf " message formats
set ruler
set showcmd          " show us the command we're typing
set showmode
set mouse=a

set laststatus=2
set t_Co=256

colorscheme Tomorrow-Night-Eighties

" vim behaviour
command! W :w " for mistyping :w as :W
let mapleader = ',' " remap leader key to ,

" folding options
set foldmethod=syntax
set foldlevel=0
set foldcolumn=3
let javaScript_fold=1
let xml_syntax_folding=1

" directories for .swp files
set directory=~/.vim/swp//,/tmp//
set tags+=tags;/ " search recursively upwards for the tags file
set wildignore=**/cache/**,**/build/**,**/logs/**

syntax on           " enable syntax highlight
filetype on
filetype indent on
filetype plugin on

" spelling options
set spelllang=es_es,en_us

" mark the lines above 120 columns
highlight OverLength ctermbg=red ctermfg=white gui=undercurl guisp=red
match OverLength /\%121v.\+/

" mark the columns that are close to overlength limit
highlight LineProximity gui=undercurl guisp=orange
let w:m1=matchadd('LineProximity', '\%<121v.\%>115v', -1)


function! UpdateBundles()
  let cmd = "ruby ~/.dotfiles/vim/bin/vim-update-bundles.rb"
  echo "running: ".cmd." this could take a while ..."

  let tmpfile = tempname()
  let cmd = cmd." > ".tmpfile
  call system(cmd)

  let efm_bak = &efm
  set efm=%m
  execute "silent! cgetfile ".tmpfile
  let &efm = efm_bak
  botright copen

  call delete(tmpfile)
endfunction

command! -complete=file UpdateBundles call UpdateBundles()


"----------------------------------------------
" black magic section, handle it with caution
"-----------------------------------------------

" variable name refactoring for local and global scopes
" move te cursor to a variable name and pres gr o gR to apply the refactoring
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>
nnoremap gR gD[{V%:s/<C-R>///gc<left><left><left>


"**************************************************************
"                      Bundle plugins                         *
"**************************************************************

" Snipmate
" Bundle: http://github.com/msanders/snipmate.vim.git


" NerdTree
" Bundle: http://github.com/Xuyuanp/nerdtree
"-- Bundle: http://github.com/scrooloose/nerdtree.git
let g:nerdtree_show_git_status = 1
map <F1> :NERDTreeToggle<CR>


" Vim surround
" Bundle: http://github.com/tpope/vim-surround.git


" PHP Syntax (updated to 5.4)
" Bundle: https://github.com/mageekguy/php.vim
let php_sql_query = 1
let php_htmlInStrings = 1
let php_parent_error_close = 1
let php_folding = 3
let php_baselib = 1
let php_special_vars = 1


" PHP Debugger
" Bundle: https://github.com/vim-scripts/DBGPavim.git


" PHP Documentor for Vim
" Bundle: https://github.com/mikehaertl/pdv-standalone
nnoremap <Leader>pd :call PhpDocSingle()<CR>


" Syntastic, syntax checker for various languages
" Bundle: http://github.com/scrooloose/syntastic.git
"
" Clone this repository into PHP CodeSniffer standards directory:
"
" git clone http://github.com/opensky/Symfony2-coding-standard.git Symfony2
"
" And execute this command:
"
" phpcs --config-set default_standard Symfony2


" TagBar
" Bundle: git://github.com/majutsushi/tagbar
map <F2> :TagbarToggle<CR>
let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_foldlevel = 1
let g:tagbar_autofocus = 1


" Local vimrc, enables per-project configurations
" Bundle: http://github.com/thinca/vim-localrc.git


" Tabular
" Bundle: http://github.com/godlygeek/tabular.git


" Ack, a better grep 
" Bundle: http://github.com/mileszs/ack.vim
let g:ack_autofold_results = 1


" Match it
" Bundle: http://github.com/vim-scripts/matchit.zip.git


" Less annoying delimiters - DelimitMate
" Bundle: http://github.com/Raimondi/delimitMate.git
let delimitMate_smart_quotes = 1
"let delimitMate_autoclose = 1


" Lorem ipsum dummy text generator
" Bundle: http://github.com/vim-scripts/loremipsum.git


" Increment
" Bundle: http://github.com/triglav/vim-visual-increment.git


" Sparkup
" Bundle: http://github.com/rstacruz/sparkup.git
" BundleCommand: make vim-pathogen


" Vim rails
" Bundle: http://github.com/tpope/vim-rails.git


" Gundo
" -Bundle: http://github.com/sjl/gundo.vim.git
"nnoremap <F3> :GundoToggle<CR>


" Camel case motion
" Bundle: http://github.com/vim-scripts/camelcasemotion.git


" MatchTag, highlight a paired HTML tags
" Bundle: http://github.com/vim-scripts/MatchTag.git


" Arg text object, motions for function/method arguments
" Bundle: http://github.com/vim-scripts/argtextobj.vim.git


" Inline snippets edit
" Bundle: http://github.com/vim-scripts/inline_edit.vim.git


" Fugitive, Git integration for vim. This plugin is used to show current branch
" in vim's statusline.
" Bundle: https://github.com/tpope/vim-fugitive


" Vim powerline statusbar
" Bundle: http://github.com/Lokaltog/vim-powerline.git
" BundleCommand: git checkout develop; git pull origin develop; rm -f *.cache
if has("gui_running")
  let g:Powerline_symbols = 'fancy'
endif


" C++ omnicomplete feature
" Bundle: http://github.com/vim-scripts/OmniCppComplete.git


" Better syntax highligh for C++
" Bundle: http://github.com/vim-scripts/cpp.vim--Skvirsky


" Better syntax dor C++ STL
" Bundle: https://github.com/vim-scripts/stl.git


" Switch between .cpp and .hpp files
" Bundle: https://github.com/vim-scripts/FSwitch.git
nnoremap <F8> :FSHere<CR>
au! BufEnter *.cpp,*.c let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = './,../include'
au! BufEnter *.hpp,*.h let b:fswitchdst = 'cpp,c' | let b:fswitchlocs = './,../src'
let g:protodefprotogetter = $HOME . '/.vim/bundle/ProtoDef/pullproto.pl'


" Generates skeleton methods using C++ headers
" Bundle: https://github.com/vim-scripts/ProtoDef.git


" Vombato, an improved wombat color scheme
" Bundle: https://github.com/molok/vim-vombato-colorscheme.git


" Pyte, a light color schema
" Bundle: https://github.com/vim-scripts/pyte.git


" Buffet, plugin to handle list of buffers
" Bundle: https://github.com/vim-scripts/buffet.vim.git


" Ctrl+P
" Bundle: https://github.com/kien/ctrlp.vim.git
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'


" Vim ruby
" Bundle: https://github.com/vim-ruby/vim-ruby.git


" Jinja syntax
" Bundle: https://github.com/Glench/Vim-Jinja2-Syntax


" Tomorrow night eighties
" Bundle: http://github.com/chriskempson/vim-tomorrow-theme.git


"**************************************************************
"                Autocmds and keybindings                     *
"**************************************************************

" load keymaps after plugin load
autocmd VimEnter * source ~/.vimrc-keymaps

if has("autocmd")
  source ~/.vimrc-au
endif

