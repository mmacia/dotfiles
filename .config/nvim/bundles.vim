let data_dir = stdpath('data').'/site'

if empty(glob(data_dir.'/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin()

" --- common plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'leafOfTree/vim-matchtag'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-tree/nvim-tree.lua' " tree view
Plug 'junegunn/vim-easy-align'
Plug 'stevearc/aerial.nvim'  " Class layout
Plug 'chaoren/vim-wordmotion'
Plug 'mortepau/codicons.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'windwp/nvim-autopairs'  " autoclose pairs
Plug 'RRethy/nvim-treesitter-endwise' " autoclose ends in languages like ruby, lua, vimscript, elixir, etc
Plug 'lewis6991/gitsigns.nvim'
Plug 'jghauser/mkdir.nvim'       " create directories if not exists as you go


" --- omnicompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-omni'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip', { 'do': 'make install_jsregexp' }
Plug 'saadparwaiz1/cmp_luasnip'

" --- Testing
Plug 'antoinemadec/FixCursorHold.nvim'  " neotest dep
Plug 'nvim-neotest/nvim-nio'            " neotest dep
Plug 'nvim-neotest/neotest'             " run tests
Plug 'nvim-neotest/neotest-python'      " pytest adapter
Plug 'olimorris/neotest-rspec'          " rspec adapter
Plug 'jfpedroza/neotest-elixir'         " elixir adapter

" --- Crystal plugins
Plug 'vim-crystal/vim-crystal'  " crystal syntax

" --- Python plugins
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }  " Autocomplete

" --- Ruby / Rails plugins
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'mattn/emmet-vim'
Plug 'AndrewRadev/tagalong.vim'

" --- C++ plugins
Plug 'peterhoeg/vim-qml', { 'for': 'cpp' }       " QML syntax
Plug 'cdelledonne/vim-cmake', { 'for': 'cpp' }   " CMake integration

" --- Writing plugins
Plug 'junegunn/goyo.vim'              " distraction free writing
Plug 'vimwiki/vimwiki'                " wiki for vim

" --- LSP stuff
Plug 'neovim/nvim-lspconfig'
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'nvimtools/none-ls.nvim'  " use refactor actions, formatters, linters, etc with LSP
Plug 'nvim-lua/plenary.nvim'   " none-ls dep

" --- Opencode stuff
Plug 'NickvanDyke/opencode.nvim'
Plug 'folke/snacks.nvim'

" --- Themes
Plug 'ellisonleao/gruvbox.nvim'

" --- Other
Plug 'vim-scripts/loremipsum'         " Lorem ipsum generator
Plug 'nvim-lualine/lualine.nvim'      " a stylized status line
Plug 'christoomey/vim-tmux-navigator' " navigate between tmux and vim
Plug 'shime/vim-livedown'             " Live preview for markdown
Plug 'AndrewRadev/sideways.vim'       " Swap arguments
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': ['jinja2'] } " Jinja2 syntax
Plug 'nvim-focus/focus.nvim',         " Focus panels and splits

call plug#end()
