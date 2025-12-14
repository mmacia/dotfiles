local M = {}

function M.config()
  require('nvim-treesitter').setup({
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

  require('nvim-treesitter').install {
      'bash',
      'c',
      'cmake',
      'cpp',
      'css',
      'diff',
      'dockerfile',
      'eex',
      'elixir',
      'embedded_template',
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
      'vimdoc',
      'yaml',
    }
end

return M
