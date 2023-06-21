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
      'eex',
      'elixir',
      'embedded_language',
      'erlang',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'graphql',
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
      'sql',
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
