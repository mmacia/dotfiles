local M = {}

function M.config()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'cpp',
      'css',
      'diff',
      'dockerfile',
      'elixir',
      'eex',
      'erlang',
      'html',
      'heex',
      'javascript',
      'json',
      'latex',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'php',
      'python',
      'regex',
      'rst',
      'ruby',
      'rust',
      'scss',
      'toml',
      'typescript',
      'vim',
      'yaml',
    },
    highlight = { enable = true },
    indent = { enable = true },
    autotag = {
      enable = true,
      filetypes = {
        'html',
        'javascript',
        'typescript',
        'xml',
      }
    },
    endwise = { enable = true },
  })
end

return M
