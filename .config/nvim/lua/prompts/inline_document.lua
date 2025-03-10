local system = require("prompts.system")

return {
  strategy = "inline",
  description = "Add documentation for code  -- inline",
  opts = {
    modes = { "v" },
    short_name = "inline-doc",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "user",
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return "Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.\n\n```"
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
