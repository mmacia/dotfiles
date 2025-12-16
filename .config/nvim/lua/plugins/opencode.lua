local M = {}

function M.config()
  require('snacks').setup({
     input = {enabled = true},
     picker = {enabled = true},
     terminal = {enabled = true}
  })

  local opencode = require('opencode')

  -- Required for `opts.auto_reload`
  vim.opt.autoread = true

  -- Recommended/example keymaps
  vim.keymap.set({'n', 'v'}, '<leader>oa', function() opencode.ask('@this: ', { submit = true }) end, { desc = 'Ask about this' })
  vim.keymap.set('n', '<leader>ot', function() opencode.toggle() end, { desc = 'Toggle opencode' })
  vim.keymap.set('n', '<leader>o+', function() opencode.prompt('@buffer', { append = true }) end, { desc = 'Add buffer to prompt' })
  vim.keymap.set('n', '<S-C-u>',    function() opencode.command('messages_half_page_up') end, { desc = 'Messages half page up' })
  vim.keymap.set('n', '<S-C-d>',    function() opencode.command('messages_half_page_down') end, { desc = 'Messages half page down' })
  vim.keymap.set({ 'n', 'v' }, '<leader>os', function() opencode.select() end, { desc = 'Select prompt' })

  vim.g.opencode_opts = {
    provider = {
      enabled = 'tmux',
      tmux = {
        options = '-h -p 50'
      }
    }
  }
end

return M
