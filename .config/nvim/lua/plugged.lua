---
--- Pluggin settings
---

require('plugins/nvim-treesitter').config()
require('plugins/nvim-cmp').config()
require('plugins/lsp').config()
require('plugins/null-ls').config()

-- autopairs
require('nvim-autopairs').setup()


-- gitsigns
require('gitsigns').setup()

--
-- overlength plugin
local overlength = require('overlength')

overlength.setup({
  enabled = true,
  default_overlenght = 120,
  disable_ft = { 'help', 'qf', '', 'NvimTree', 'html', 'css', 'scss' }
})
overlength.set_overlength('markdown', 80)
overlength.set_overlength('vimwiki', 80)


-- aerial plugin
require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr})
  end
})


-- nvim tree

local split = function(str, sep)
  local sep, fields = sep or ",", {}
  local pattern = string.format("([^%s]+)", sep)
  str:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

local custom_ignores = { '^.git$' }

-- nvim-tree requires wildignore folders to be in format ^name$
for _, v in ipairs(split(vim.o.wildignore)) do
  if v:sub(1, 1) ~= '*' then
    table.insert(custom_ignores, '^' .. v:sub(1, -1) .. '$')
  end
end

require('nvim-tree').setup({
  filters = {
    custom = custom_ignores,
  }
})


-- FZF
vim.g['fzf_history_dir'] = vim.fn.stdpath('cache') .. '/fzf'


-- lualine.nvim

require('lualine').setup({
  options = {
    theme = 'gruvbox',
  },
  sections = {
    lualine_a = {
      { 'mode', fmt = function(mode) return vim.go.paste == true and mode .. ' | PASTE' or mode end },
    }
  },
})


-- Rafactoring
require('refactoring').setup({})


-- cmake

vim.g.cmake_build_dir_location = './build'


-- vimwiki
local nested_syntaxes = {}

nested_syntaxes['python'] = 'python'
nested_syntaxes['c++'] = 'cpp'
nested_syntaxes['ruby'] = 'ruby'
nested_syntaxes['crystal'] = 'crystal'
nested_syntaxes['rust'] = 'rust'

vim.g.vimwiki_list = {
  {
    path ='~/Documents/Wiki/',
    syntax = 'markdown',
    ext = '.md',
    nested_syntaxes = nested_syntaxes
  },
  -- {
  --   path ='~/second_brain/',
  --   syntax = 'markdown',
  --   ext = '.md',
  --   template_path = '~/second_brain/templates',
  --   template_default = 'default',
  --   nested_syntaxes = nested_syntaxes,
  --   diary_rel_path = "journal/"
  -- }
}

vim.g.vimwiki_listsyms = ' ○◐●✓'
vim.g.vimwiki_global_ext = 0


-- markdown
vim.g.markdown_fenced_languages = { 'html', 'python', 'bash=sh', 'ruby', 'vim', 'rust', 'crystal', 'cpp' }
vim.g.markdown_minlines = 100


-- nvim-test
require('nvim-test').setup()


-- vim-chatgpt
vim.g.chat_gpt_max_tokens = 2000
