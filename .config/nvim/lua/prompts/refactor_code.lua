local system = require("prompts.system")

return {
  strategy = "chat",
  description = "Refactor the provided code snippet  -- chat, has_system_prompt",
  opts = {
    short_name = "refactor-code",
    auto_submit = false,
    is_slash_cmd = true,
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
      content = "Please refactor the following code to improve its clarity and readability.",
    },
  },
}
