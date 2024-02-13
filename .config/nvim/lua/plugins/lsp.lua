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
    buf_set_keymap('n', 'ld', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

    --buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end



  ---
  --- Diagnostics setup
  ---
  vim.diagnostic.config({
    underline = true,
    signs = true,
    float = {
      show_header = true,
      source = 'if_many',
      border = 'rounded',
      focusable = false
    },
    severity_sort = true,
  })


  ---
  --- Python setup
  ---
  if vim.fn.executable('pylsp') then
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('lspconfig').pylsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            mypy            = { enabled = true },
            pyflakes        = { enabled = true },
            ruff            = { enabled = true },
            jedi_completion = { enabled = true, fuzzy = true },
            jedi_definition = {
              enabled = true ,
              follow_imports = true,
              follow_builtin_imports = true
            },
            jedi_hover = { enabled = true },
            jedi_references = { enabled = true },
            jedi_signature_help = { enabled = true },
            jedi_symbols = { enabled = true, all_scopes = true },
            --rope_autoimport = { enabled = true, memory = true },     not working
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
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

    require('lspconfig').html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
  if vim.fn.executable('emmet-language-server') then
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('lspconfig').emmet_language_server.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {
        "css", "eruby", "heex", "html", "javascript", "less", "saas", "javascriptreact", "scss", "svelte", "pug",
        "typescriptreact", "vue" },
      init_options = {
        -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
        -- **Note:** only the options listed in the table are supported.
        triggerExpansionOnTab = true,
        includeLanguages = {
          ["html-eex"] = "html",
          ["phoenix-heex"] = "html",
          eruby = "html",
        },
      }
    })
  end


  ---
  --- Elixir LSP
  ---
  if vim.fn.filereadable(os.getenv('ASDF_DATA_DIR') .. '/shims/elixir-ls') then
    local util = require('lspconfig.util')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    require('lspconfig').elixirls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = util.root_pattern('mix.exs', '.git'),
      cmd = { os.getenv('ASDF_DATA_DIR') .. "/shims/elixir-ls" },
    })

  end
end

return M
