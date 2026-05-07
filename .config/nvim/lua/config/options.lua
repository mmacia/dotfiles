-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.shortmess:remove("I") -- remove lazyvim welcome message

local create_user_command = vim.api.nvim_create_user_command

-- handle mistypings
create_user_command("WQ", "wq", { bang = true, desc = "Mistyped :wq" })
create_user_command("Wq", "wq", { bang = true, desc = "Mistyped :wq" })
create_user_command("W", "w", { bang = true, desc = "Mistyped :w" })
create_user_command("Q", "q", { bang = true, desc = "Mistyped :q" })
create_user_command("Qa", "qa", { bang = true, desc = "Mistyped :qa" })
