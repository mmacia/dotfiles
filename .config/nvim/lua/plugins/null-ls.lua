local M = {}

function M.config()
  local null_ls = require('null-ls')
  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

  null_ls.setup({
    root_dir = require('null-ls.utils').root_pattern(
      '.null-ls-root',
      '.python-version',
      '.ruby-version',
      'Gemfile',
      'Makefile',
      '.git',
      'package.json'
    ),
    sources = {
      -- General
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.formatting.prettier,

      -- Markdown
      --null_ls.builtins.formatting.remark,
      null_ls.builtins.diagnostics.proselint,

      -- Python
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,

      -- Ruby
      null_ls.builtins.diagnostics.rubocop,
      null_ls.builtins.formatting.rubocop,

      -- C++
      null_ls.builtins.formatting.clang_format,

      -- Elixir
      null_ls.builtins.diagnostics.credo,
      null_ls.builtins.formatting.mix,
    },

    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
          end,
        })
      end
    end,
  })
end

return M
