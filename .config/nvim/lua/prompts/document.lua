local system = require("prompts.system")

return {
  strategy = "chat",
  description = "Write documentation for code  -- chat",
  opts = {
    modes = { "v" },
    short_name = "doc",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "user",
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return "Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.\n\n```"
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
