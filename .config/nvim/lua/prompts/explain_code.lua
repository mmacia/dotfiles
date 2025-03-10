local system = require("prompts.system")

return {
  strategy = "chat",
  description = "Explain how code works  -- chat, has_system_prompt",
  opts = {
    short_name = "explain-code",
    auto_submit = false,
    is_slash_cmd = true,
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
      content = [[Please explain how the following code works.]],
    },
  },
}
