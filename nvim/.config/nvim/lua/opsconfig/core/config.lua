local project_root = vim.fn.getcwd()
local config_file = project_root .. "/.nvim.lua"
local local_config = {}

if vim.fn.filereadable(config_file) == 1 then
	local_config = loadfile(config_file)()

	if not type(local_config) == "table" then
		local_config = {}
	end
end

local config = {
	global = require("odara.config.global"),
	plugins = require("odara.config.plugins"),
}

local servers_config = {}

config.global.is_dev = false
config.global.is_servers = true

config = vim.tbl_deep_extend("force", config, servers_config, local_config)

vim.g.opsconfig = config
