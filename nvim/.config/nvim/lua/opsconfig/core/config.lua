local project_root = vim.fn.getcwd()
local config_file = project_root .. '/.nvim.lua'
local local_config = {}

if vim.fn.filereadable(config_file) == 1 then
  local_config = loadfile(config_file)()

  if not type(local_config) == 'table' then
    local_config = {}
  end
end

local config = {
  global = require('opsconfig.config.global'),
  plugins = require('opsconfig.config.plugins'),
}

local opsconfig_type = os.getenv('OPSCONFIG_TYPE') or 'dev'
local servers_config = {}

if opsconfig_type == 'servers' then
  config.global.is_dev = true
  config.global.is_servers = true

  servers_config = require('opsconfig.config.servers')
else
  config.global.is_dev = true
  config.global.is_servers = false
end

-- NOTE: Per project deployment configuration
local deployment_config_file = project_root .. '/.nvim/deployment.lua'

if vim.fn.filereadable(deployment_config_file) == 1 then
  config.global.remote_server.enabled = true
end

config = vim.tbl_deep_extend('force', config, servers_config, local_config)

vim.g.opsconfig = config
