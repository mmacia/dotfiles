local M = {}

function M.config()
  local cmp = require('cmp_nvim_lsp')

  local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>k', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    --vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, opts)

    -- auto format on save
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = true, timeout_ms = 5000 })
        end,
      })
    end
  end

  local get_capabilities = function()
    return vim.tbl_deep_extend(
      'force',
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp.default_capabilities()
    )
  end

  local servers = {
    'expert',
    'tailwindcss',
    'html',
    'emmet_language_server',
    'crystaline',
    'clangd',
    'solargraph',
    'pylsp',
  }

  vim.lsp.enable(servers)


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

  vim.lsp.config('*', {
    on_attach = on_attach,
    capabilities = get_capabilities(),
  })

  ---
  --- Python setup
  ---
  if vim.fn.executable('pylsp') then
    vim.lsp.config('pylsp', {
      settings = {
        pylsp = {
          plugins = {
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
    vim.lsp.config('solargraph', {
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

    vim.lsp.config('clangd', {
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
  vim.lsp.config('crystaline', {})

  ---
  --- HTML setup
  ---
  vim.lsp.config('emmet_language_server', {
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

  ---
  --- Elixir LSP
  ---
  if vim.fn.executable('expert') then
    vim.lsp.config('expert', {
      cmd = { 'expert' },
      root_markers = { 'mix.exs', '.git' },
      filetypes = { 'elixir', 'eelixir', 'heex' },
    })
  end
end

return M
