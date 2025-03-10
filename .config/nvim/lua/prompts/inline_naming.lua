local system = require("prompts.system")

return {
  strategy = "inline",
  description = "Give better naming for the provided code snippet  -- inline",
  opts = {
    modes = { "v" },
    short_name = "naming",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "user",
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return "Please provide better names for the following variables and functions:\n\n```"
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
