-- lua/opsconfig/plugins/ui/lualine/components/autosave.lua
local lualine_require = require('lualine_require')
local M = lualine_require.require('lualine.component'):extend()

function M:init(options)
  M.super.init(self, options)
  self.enabled = options and options.enabled ~= false
end

function M:update_status()
  if not self.enabled then
    return ''
  end

  local is_active = _G.autosave_statusline and _G.autosave_statusline() ~= '󱂬 Off'

  self.options.icon = nil
  self.options.color = {
    fg = is_active and '#98be65' or '#5C6370',
  }

  return '󱂬'
end

return M
