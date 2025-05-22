local M = {}

--- Load lualine component by name from the opsconfig namespace.
--- @param name string: component name (e.g. 'autosave')
--- @param opts table|nil: options to pass to component:init
--- @return any: configured lualine component instance
function M.use(name, opts)
  local component = require('opsconfig.plugins.ui.lualine.components.' .. name)
  if type(component) == 'table' and component.init then
    return component:new(opts or {})
  end
  return component
end

return M
