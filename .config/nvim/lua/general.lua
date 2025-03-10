---
-- General settings
---

local set = vim.opt

-- sensitive defaults
set.number = true       -- show line numbers
set.smartindent = true
set.fileformat = 'unix' -- endline setted to \n
set.autowrite = true    -- automatically :w before running commands

-- identation
set.tabstop = 2
set.shiftwidth = 2
set.shiftround = true
set.expandtab = true

set.shada = "%,<100,'100,/100,:100,s100,h,f1"  -- shared data between sessions

set.errorbells = false    -- do not constantly beep and make me nuts
set.ignorecase = true     -- case insensitive search
set.hlsearch = true       -- hilight searches by default
set.cursorline  = true    -- highlight current line

-- Make it obvious where 120 column is
set.textwidth = 120
set.colorcolumn = '+1'

-- undo
set.undofile = true
set.undolevels = 1000  -- maximum number of changes that can be undoed
set.undoreload = 1000  -- maximum number lines to save for undo on a buffer reload

-- basic ui settings
set.shortmess = 'atWswxrnmlf'  -- message formats
set.showmode = true
set.showcmd = true             -- show the command we're typing
set.background = 'dark'

-- use the system clipboard
set.clipboard = 'unnamedplus'

-- ignore dirs/files
set.wildignore:append { 'tmp', 'log', 'logs', '.DS_Store' }
set.wildignore:append { '__pycache__', 'htmlcov', 'coverage', '.coverage', '*.pyc', '.mypy', '.pytest_cache' }  -- python
set.wildignore:append { '.gems', '.bundle' }                                                   -- ruby
set.wildignore:append { '*.o', '*.obj', 'a.out', 'build', 'target' }                           -- c++
set.wildignore:append { 'node_modules' }                                                       -- javascript
set.wildignore:append { '*.class' }                                                            -- java
set.wildignore:append { '*.swp' }                                                              -- vim
set.wildignore:append { 'deps', '_build', '*.beam', '.elixir_ls' }                             -- elixir

-- spell settings
set.spelllang = 'es_es,en_us'
set.complete:append 'kspell'

-- view special characters
set.list = true
set.listchars = { tab = '· ', eol = '¬' }
