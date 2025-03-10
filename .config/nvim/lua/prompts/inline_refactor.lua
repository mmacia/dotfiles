local system = require("prompts.system")

return {
  strategy = "inline",
  description = "Refactor the provided code snippet  -- inline, has_system_prompt",
  opts = {
    modes = { "v" },
    short_name = "refactor",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "system",
      content = system.CODE_REFACTOR,
      opts = {
        visible = false,
      },
    },
    {
      role = "user",
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return "Please refactor the following code to improve its clarity and readability:\n\n```"
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
