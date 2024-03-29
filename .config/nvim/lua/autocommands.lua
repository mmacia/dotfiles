---
--- Autocommands
---

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local keymap = vim.api.nvim_set_keymap
local set = vim.opt
local setlocal = vim.opt_local


-- file warmups
autocmd('BufNewFile', { pattern = '*.go', command = 's-^-package main\r\rimport "fmt"\r\rfunc main() {\r\r}-' })
autocmd('BufNewFile', { pattern = '*.sh', command = 's-^-#!/bin/bash\r\r-' })
autocmd('BufNewFile', { pattern = '*.c', command = 's-^-#include <stdio.h>\r\rint main(int argc, char** argv) {\r\treturn 0;\r}-' })
autocmd('BufNewFile', { pattern = '*.h', command = 's-^-#pragma once\r\r-' })
autocmd('BufNewFile', { pattern = '*.php', command = 's-^-<?php\r\r-' })
autocmd('BufNewFile', { pattern = '*.rb', command = 's-^-# frozen_string_literal: true\r\r-' })

-- Jinja2 syntax colors
autocmd('BufRead', { pattern = '*.j2,*.twig', command = 'set filetype=jinja' })

-- nicer comments
autocmd({ 'BufNewFile', 'BufRead' }, { pattern = '*.h,*.c,*.cpp,*.php', command = 'set comments=s:/**,mb:*,ex:*/' })

-- Jenkinsfiles
autocmd({ 'BufNewFile', 'BufRead' }, { pattern = 'Jenkinsfile', command = 'setf groovy' })

-- Elixir and Phoenix
autocmd({ 'BufRead', 'BufNewFile' }, { pattern = '*.ex,*.exs', command = 'set filetype=elixir' })
autocmd({ 'BufRead', 'BufNewFile' }, { pattern = '*.heex', command = 'set filetype=heex' })
autocmd({ 'BufRead', 'BufNewFile' }, { pattern = '*.eex,*.leex,*.sface,*.lexs', command = 'set filetype=eex' })
autocmd({ 'BufRead', 'BufNewFile' }, { pattern = 'mix.lock', command = 'set filetype=elixir' })

---
--- CPP autogroup
---

local cpp_files = '*.cpp,*.cxx,*.h,*.hpp,*.hxx,*.cc,*.c'
local cpp_group = 'FileTypeCPP'

augroup(cpp_group, { clear = true })
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = cpp_goup,
  pattern = cpp_files,
  callback = function()
    keymap('n', '<Leader>b', ':CMakeBuild<CR>', { noremap = true, desc = 'Launch build task' })
    keymap('n', '<Leader>q', ':CMakeClose<CR>', { noremap = true, desc = 'Close build pane' })
    keymap('n', '<Leader>g', ':CMakeGenerate<CR>', { noremap = true, desc = 'Generate CMake project' })
    keymap('n', '<F3>', ':ClangdSwitchSourceHeader<CR>', { noremap = true, desc = 'Switch between Headers/Source files' })
  end
})


---
--- Python
---

local python_group = 'FileTypePython'

augroup(python_group, { clear = true })
autocmd({ 'FileType' }, {
  group = python_goup,
  pattern = 'python',
  callback = function()
    set.cursorcolumn = true
  end
})


---
--- Text files
---

local text_group = 'FileTypeText'
local text_fts = 'text,tex,markdown,vimwiki,gitcommit'

augroup(text_group, { clear = true })
autocmd({ 'FileType' }, {
  group = text_goup,
  pattern = text_fts,
  callback = function()
    setlocal.textwidth = 80
    setlocal.spell = true
  end
})


---
--- Disable focus on special windows
---
--
local ignore_filetypes = { 'neo-tree', 'NvimTree', 'aerial' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

local augroup = augroup('FocusDisable', { clear = true })

autocmd('WinEnter', {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = "Disable focus autoresize for BufType",
})

autocmd('FileType', {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.b.focus_disable = true
    else
      vim.b.focus_disable = false
    end
  end,
  desc = "Disable focus autoresize for FileType",
})
