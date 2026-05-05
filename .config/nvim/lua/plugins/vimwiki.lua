return {
  "vimwiki/vimwiki",
  -- The event that triggers the plugin
  event = "BufEnter *.md",
  -- The keys that trigger the plugin
  keys = { "<leader>ww", "<leader>wt" },
  -- The configuration for the plugin
  init = function()
    local nested_syntaxes = {}

    nested_syntaxes["python"] = "python"
    nested_syntaxes["c++"] = "cpp"
    nested_syntaxes["ruby"] = "ruby"
    nested_syntaxes["crystal"] = "crystal"
    nested_syntaxes["rust"] = "rust"
    nested_syntaxes["elixir"] = "elixir"

    vim.g.vimwiki_list = {
      {
        path = "~/Documents/Wiki/",
        syntax = "markdown",
        ext = ".md",
        nested_syntaxes = nested_syntaxes,
      },
      -- {
      --   path ='~/second_brain/',
      --   syntax = 'markdown',
      --   ext = '.md',
      --   template_path = '~/second_brain/templates',
      --   template_default = 'default',
      --   nested_syntaxes = nested_syntaxes,
      --   diary_rel_path = "journal/"
      -- }
    }

    vim.g.vimwiki_listsyms = " ○◐●✓"
    vim.g.vimwiki_global_ext = 0
  end,
}
