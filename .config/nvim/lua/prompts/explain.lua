local system = require("prompts.system")

return {
  strategy = "chat",
  description = "Explain how code in a buffer works  -- chat, has_system_prompt",
  opts = {
    default_prompt = true,
    modes = { "v" },
    short_name = "explain",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "system",
      content = system.CODE_EXPLAIN,
      opts = {
        visible = false,
      },
    },
    {
      role = "user",
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return "Please explain how the following code works:\n\n```" .. context.filetype .. "\n" .. code .. "\n```\n\n"
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
