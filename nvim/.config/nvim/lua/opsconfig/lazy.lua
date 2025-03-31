local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazy_path,
  })
end

vim.opt.rtp:prepend(lazy_path)

local lazy_imports = {}

local plugin_path = 'opsconfig.plugins'

local scan = vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/' .. plugin_path:gsub('%.', '/'), '*', false, true)

for _, path in ipairs(scan) do
  local name = path:match('.*/([^/]+)$')

  if vim.fn.isdirectory(path) == 1 then
    table.insert(lazy_imports, { import = plugin_path .. '.' .. name })
  end
end

local lazy_options = {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
}

require('lazy').setup(lazy_imports, lazy_options)
