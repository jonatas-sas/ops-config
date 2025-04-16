return {
  -- NOTE:  AI-powered command palette and interface for Neovim.
  --  Uses local LLMs via Ollama to enhance interaction with Neovim.
  --  Boosts productivity by enabling natural language commands and queries.
  --  Configurable, with support for custom prompts, providers, and keybindings.
  --  Repository: https://github.com/yetone/avante.nvim
  'yetone/avante.nvim',

  event = 'VeryLazy',

  version = false,

  build = 'make',

  opts = {
    provider = 'claude',
    claude = {
      endpoint = 'https://api.anthropic.com',
      model = 'claude-3-5-sonnet-20241022',
      temperature = 0,
      max_tokens = 4096,
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
  },
}
