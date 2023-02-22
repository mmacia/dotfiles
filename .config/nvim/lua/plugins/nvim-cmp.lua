local M = {}

function M.config()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  require('luasnip.loaders.from_snipmate').load()

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = cmp.mapping.preset.insert {
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<CR>'] = cmp.mapping.confirm { select = true },
      ['<C-e>'] = cmp.mapping.abort(),
      ['<ESC>'] = cmp.mapping.close(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
    },
    sources = {
      { name = 'nvim_lsp' },                   -- for nvim-lsp
      --{ name = "omni" },
      { name = 'path' },                       -- for path completion
      { name = 'luasnip' },
      { name = 'buffer', keyword_length = 2 }, -- for buffer word completion
      { name = 'emoji', insert = true },       -- for emoji completion
    },
    completion = {
      --keyword_length = 1,
      completeopt = 'menu,noselect',
    },
    view = {
      entries = 'custom'
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol_text',
        menu = {
          nvim_lsp = '[LSP]',
          path     = '[Path]',
          buffer   = '[Buffer]',
          emoji    = '[Emoji]',
          omni     = '[Omni]',
        },
        symbol_map = {
          Class = '',
        },
      }
    },
  }

  -- File types specifics
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = "cmp_git" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.filetype('html', {
    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'path' },                       -- for path completion
      { name = 'buffer', keyword_length = 2 }, -- for buffer word completion
      { name = 'emoji', insert = true },       -- for emoji completion
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.filetype('eruby', {
    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'path' },                       -- for path completion
      { name = 'buffer', keyword_length = 2 }, -- for buffer word completion
      { name = 'emoji', insert = true },       -- for emoji completion
    }, {
      { name = "buffer" },
    }),
  })

  -- command line completion
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })
end

return M
