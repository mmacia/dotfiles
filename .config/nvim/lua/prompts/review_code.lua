local system = require("prompts.system")

return {
  strategy = "chat",
  description = "Review code and provide suggestions for improvement  -- chat, has_system_prompt",
  opts = {
    short_name = "review-code",
    auto_submit = false,
    is_slash_cmd = true,
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
      content = "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability.",
    },
  },
}
