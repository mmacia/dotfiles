local system = require("prompts.system")

return {
  strategy = "inline",
  description = "Review the provided code snippet  -- inline, has_system_prompt",
  opts = {
    modes = { "v" },
    short_name = "review",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "system",
      content = system.CODE_REVIEW,
      opts = {
        visible = false,
      },
    },
    {
      role = "user",
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```"
          .. context.filetype
          .. "\n"
          .. code
          .. "\n```\n\n"
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
