local M = {}

function M.config()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<Leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    --buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  ---
  --- Python setup
  ---
  if vim.fn.executable('pylsp') then
    require('lspconfig').pylsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            configurationSources = { "flake8" },
            autopep8        = { enabled = false },
            flake8          = { enabled = true },
            mypy            = { enabled = true },
            pycodestyle     = { enabled = true },
            pydocstyle      = { enabled = false },
            pyflakes        = { enabled = true },
            pylint          = { enabled = true },
            black           = { enabled = false },
            jedi_completion = { enabled = true },
            jedi_definition = {
              enabled = true ,
              follow_imports = true,
              follow_builtin_imports = true
            },
            jedi_hover = { enabled = true },
            jedi_references = { enabled = true },
            jedi_signature_help = { enabled = true },
            mccabe = { enabled = true },
            rope_autoimport = { enabled = true, memory = true },
            yapf = { enabled = true },
          },
        }
      }
    })
  end


  ---
  --- Ruby setup
  ---
  if vim.fn.executable('solargraph') then
    local util = require('lspconfig.util')

    require('lspconfig').solargraph.setup({
      on_attach = on_attach,
      root_dir = util.root_pattern('Gemfile', '.ruby-version', '.git'),
      capabilities = capabilities,
      settings = {
        solargraph = {
          diagnostics = true,
          completion = true,
          autoformat = true,
          formatting = true,
          diagnostic = true,
          folding = true,
          references = true,
          rename = true,
          symbols = true
        }
      },
      filetypes = { 'ruby', 'gemfile', 'rakefile' },
      init_options = {
        formatting = true
      }
    })
  end

  ---
  --- C++ setup
  ---
  if vim.fn.executable('clangd') then
    require('lspconfig').clangd.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { 'clangd',
        '--background-index',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--pch-storage=memory',
        '--clang-tidy',
        '--header-insertion-decorators',
        '--all-scopes-completion',
        '--offset-encoding=utf-16',
        '--inlay-hints=false',
        '--limit-results=250',
        '-j=2'
      },
      init_options = {
        clangdFileStatus     = true,
        usePlaceholders      = true,
        completeUnimported   = true,
        semanticHighlighting = true,
        InlayHints = {
          Enabled        = false,
          ParameterNames = false,
          DeducedTypes   = false,
        },
      }
    })
  end


  ---
  --- Crystal LSP setup
  ---
  if vim.fn.executable('crystalline') then
    require('lspconfig').crystalline.setup({})
  end


  ---
  --- HTML setup
  ---
  if vim.fn.executable('vscode-html-language-server') then
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require('lspconfig').html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
end

return M
