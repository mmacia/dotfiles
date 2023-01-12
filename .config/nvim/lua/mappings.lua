---
-- Custom mappings, remaps and commands
---

local create_user_command = vim.api.nvim_create_user_command
local keymap = vim.keymap

vim.g.mapleader = ','


-- handle mistypings
create_user_command('WQ', 'wq', { bang = true, desc = 'Mistyped :wq' })
create_user_command('Wq', 'wq', { bang = true, desc = 'Mistyped :wq' })
create_user_command('W', 'w', { bang = true, desc = 'Mistyped :w' })
create_user_command('Q', 'q', { bang = true, desc = 'Mistyped :q' })
create_user_command('Qa', 'qa', { bang = true, desc = 'Mistyped :qa' })


-- remaps
keymap.set('n', '<leader>r', ':redraw!<CR>:nohlsearch<CR>', { desc = 'Redraw screen and clear highlights' })


-- F keys
vim.api.nvim_set_keymap('', '<F10>', ':bdelete<CR>', { desc = 'Close current buffer' })


-- Easy align plugin
vim.api.nvim_set_keymap('x', '<Leader>a', '<Plug>(EasyAligh)', { desc = 'Aling current block' })
vim.api.nvim_set_keymap('n', '<Leader>a', '<Plug>(EasyAligh)', { desc = 'Aling current block' })


-- Swap arguments, sideways plugin
vim.api.nvim_set_keymap('n', 'sh', 'SidewaysJumpLeft<CR>', { desc = 'Jump an argument to the left' })
vim.api.nvim_set_keymap('n', 'sl', 'SidewaysJumpRight<CR>', { desc = 'Jump an argument to the right' })
vim.api.nvim_set_keymap('n', 'sH', 'SidewaysLeft<CR>', { desc = 'Move argument to the left' })
vim.api.nvim_set_keymap('n', 'sL', 'SidewaysRight<CR>', { desc = 'Move argument to the right' })


-- fzf mappings
vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { desc = 'Show fuzzy file finder' })
vim.api.nvim_set_keymap('n', '<Leader>F', ':GFiles<CR>', { desc = 'Show fuzzy git file finder' })
vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<CR>', { desc = 'Show fuzzy buffer finder' })
vim.api.nvim_set_keymap('n', '<Leader>s', ':Ag<CR>', { desc = 'Show fuzzy file contents finder' })
vim.api.nvim_set_keymap('n', '<Leader>t', ':Tags<CR>', { desc = 'Show fuzzy tag finder' })
vim.api.nvim_set_keymap('n', '<Leader>c', ':Commits<CR>', { desc = 'Show fuzzy git commit finder' })
vim.api.nvim_set_keymap('n', '<Leader>C', ':BCommits<CR>', { desc = 'Show fuzzy git commit finder (current buffer)' })


-- aerial plugin
keymap.set('n', '<F2>', '<cmd>AerialToggle!<CR>')
vim.api.nvim_set_keymap('n', '<Leader>ds', '<cmd>call aerial#fzf()<CR>', { silent = true, desc = 'Show fuzzy symbol search'})


-- nvim-tree plugin
keymap.set('n', '<F3>', '<cmd>NvimTreeToggle<CR>')
