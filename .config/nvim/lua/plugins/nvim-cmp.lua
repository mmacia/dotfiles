local M = {}

function M.config()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')

  local has_words_before = function()
    local unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  luasnip.config.set_config({
    store_selection_keys = '<Tab>',
  })
  require('luasnip.loaders.from_snipmate').lazy_load()

  cmp.setup {
    formatting = {
    format = lspkind.cmp_format {
        mode = 'symbol_text',
        menu = {
          nvim_lsp        = '[LSP]',
          path            = '[Path]',
          buffer          = '[Buffer]',
          emoji           = '[Emoji]',
          omni            = '[Omni]',
          luasnip         = '[Snippet]',
          spell           = '[Spell]',
          treesitter      = '[TS]',
          cmdline         = '[Cmd]',
          cmdline_history = '[History]'
        },
        symbol_map = {
          Class = '',
        },
      }
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<Up>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Up>"), "n", true)
        end
      end, { "i" }),
      ["<Down>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Down>"), "n", true)
        end
      end, { "i" }),
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
      ["<C-Down>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<C-Up>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-q>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm { select = true },
      ['<C-e>'] = cmp.mapping.abort(),
      ['<ESC>'] = cmp.mapping.close(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp', priority = 100, max_view_entries = 20 },
      { name = 'luasnip', priority = 120 },
      { name = 'path', priority = 100 },
      { name = 'emoji', insert = true, priority = 60 },
    }, {
      { name = "buffer", priotiry = 50 },
      -- slow
      --{ name = "omni", priority = 40 },
      { name = "treesitter", priority = 30 },
      { name = 'dictionary', keyword_length = 3, priority = 10 }
    }),

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
  }

  -- File types specifics
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
       { name = "cmp_git", priority = 100 },
       { name = "path", priority = 100 },
       { name = "emoji", insert = true, priority = 60 },
    }, {
      { name = "buffer", priority = 50 },
      { name = "spell", priority = 40 },
      { name = "treesitter", priority = 30 },
    }),
  })

  -- search completion
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' },
      { name = 'buffer' },
    }, {}),
  })

  -- command line completion
  cmp.setup.cmdline(':', {
    mapping = {
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'c' }),
      ['<S-Tab'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'c' }),
      ['C-y'] = {
        c = cmp.mapping.confirm({ select = false }),
      },
      ['<C-q>'] = {
        c = cmp.mapping.abort(),
      },
    },
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
      { name = 'cmdline_history' },
    }),
  })
end

return M
