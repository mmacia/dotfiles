lua require('general')

" load plugins
let bundles_file = stdpath('config').'/bundles.vim'

if !empty(glob(bundles_file))
  execute 'source '.bundles_file
endif

lua vim.cmd('colorscheme gruvbox')
lua require('mappings')
lua require('plugged')
lua require('autocommands')
