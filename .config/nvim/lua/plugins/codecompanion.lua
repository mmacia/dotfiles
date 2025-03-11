local M = {}

function M.config()
  local adapters = require('codecompanion.adapters')
  local prompt_library = {}

  -- load prompts
  for _, name in ipairs({
    "better_naming", -- chat, has_system_prompt
    "document", -- chat
    "explain", -- chat, has_system_prompt
    "explain_code", -- chat, has_system_prompt
    "inline_document", -- inline
    "inline_naming", -- inline
    "inline_refactor", -- inline, has_system_prompt
    "refactor_code", -- chat, has_system_prompt
    "inline_review", -- inline, has_system_prompt
    "review_code", -- chat, has_system_prompt
  }) do
    prompt_library[name] = require("prompts." .. name)
  end

  require('codecompanion').setup({
    adapters = {
      opts = {
        show_defaults = true,
      },
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = "phi4"
            },
            num_ctx = {
              default = 16384,
            },
            num_predict = {
              default = -1,
            },
          },
        })
      end,
      openai_gpt_4o_mini = function()
        return adapters.extend('openai', {
          env = { api_key = OPENAI_API_KEY },
          schema = {
            model = { default = 'gpt-4o-mini' },
            max_tokens = { default = 4096 },
            temperature = { default = 0.2 },
            top_p = { default = 0.1 },
          },
        })
      end
    },
    strategies = {
      chat = {
        adapter = "openai_gpt_4o_mini",
      },
      inline = {
        adapter = "openai_gpt_4o_mini",
      },
      agent = {
        adapter = "openai_gpt_4o_mini",
      },
    },
    prompt_library = prompt_library,
  })

  -- Show a spinner loading indicator when a request is being made
  local spinner_states = { '', '', '' }
  local current_state = 1
  local timer = vim.loop.new_timer()
  local ns_id = vim.api.nvim_create_namespace('codecompanion_loading_spinner')
  local spinner_line = nil

  local function update_spinner()
      if spinner_line then
          vim.api.nvim_buf_clear_namespace(0, ns_id, spinner_line, spinner_line + 1)
          vim.api.nvim_buf_set_virtual_text(
              0,
              ns_id,
              spinner_line,
              { { ' Loading ' .. spinner_states[current_state], 'Comment' } },
              {}
          )
          current_state = current_state % #spinner_states + 1
      end
  end

  vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionRequestStarted',
      callback = function()
          vim.defer_fn(function()
              vim.cmd('stopinsert')
          end, 1)
          spinner_line = vim.api.nvim_win_get_cursor(0)[1] - 1
          timer:start(0, 250, vim.schedule_wrap(update_spinner))
      end,
  })
  vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionRequestStreaming',
      callback = function()
          timer:stop()
          if spinner_line then
              vim.api.nvim_buf_clear_namespace(0, ns_id, spinner_line, spinner_line + 1)
              spinner_line = nil
          end
      end,
  })
  vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionRequestFinished',
      callback = function()
          if spinner_line then
              -- /fetch doesn't trigger RequestStreaming event so we also clear spinner here
              vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
              spinner_line = nil
          end
          vim.defer_fn(function()
              vim.cmd('startinsert')
          end, 1)
      end,
  })
end

return M
