local M = {}

function M.config()
  require('snacks').setup({
     input = {enabled = true}
  })

  local opencode = require('opencode')

  -- Required for `opts.auto_reload`
  vim.opt.autoread = true

  -- Recommended/example keymaps
  vim.keymap.set('n', '<leader>oa', function() opencode.ask('@cursor: ') end, { desc = 'Ask about this' })
  vim.keymap.set('v', '<leader>oa', function() opencode.ask('@selection: ') end, { desc = 'Ask about selection' })
  vim.keymap.set('n', '<leader>o+', function() opencode.prompt('@buffer', { append = true }) end, { desc = 'Add buffer to prompt' })
  vim.keymap.set('v', '<leader>o+', function() opencode.prompt('@selection', { append = true }) end, { desc = 'Add selection to prompt' })
  vim.keymap.set('n', '<leader>oe', function() opencode.prompt('Explain @cursor and its context') end, { desc = 'Explain this code' })
  vim.keymap.set('n', '<leader>on', function() opencode.command('session_new') end, { desc = 'New session' })
  vim.keymap.set('n', '<S-C-u>',    function() opencode.command('messages_half_page_up') end, { desc = 'Messages half page up' })
  vim.keymap.set('n', '<S-C-d>',    function() opencode.command('messages_half_page_down') end, { desc = 'Messages half page down' })
  vim.keymap.set({ 'n', 'v' }, '<leader>os', function() opencode.select() end, { desc = 'Select prompt' })
end

return M
