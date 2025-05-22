local plugins = vim.g.opsconfig.plugins
local global = vim.g.opsconfig.global

return {
	-- NOTE:  Manages the installation of LSPs, DAPs, linters, and formatters in Neovim.
	--  Provides a simple interface to install and update external tools.
	--  Integrates with lspconfig and null-ls for automatic configuration.
	--  Repository: https://github.com/williamboman/mason.nvim
	"williamboman/mason.nvim",

	enabled = plugins.mason_nvim and plugins.nvim_lspconfig and plugins.mason_lspconfig_nvim,

	dependencies = {
		{ "neovim/nvim-lspconfig", enabled = true },
		{ "williamboman/mason-lspconfig.nvim", enabled = true },
		{ "nvimtools/none-ls.nvim", enabled = true },
		{ "jay-babu/mason-null-ls.nvim", enabled = true },
	},

	config = function()
		local mason = require("mason")

		mason.setup()

		-- SECTION: Available LSP, Linters and Formatters

		-- SUBSECTION: LSP

		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = {
				"bashls",
				"jsonls",
				"yamlls",
			},
			automatic_installation = true,
			automatic_enable = true,
		})

		-- SUBSECTION: Formatters & Linters (none-ls)

		local mason_null_ls = require("mason-null-ls")

		mason_null_ls.setup({
			ensure_installed = {
				"stylua",
				"prettier",
				"shfmt",
				"systemd_analyze",
				"jq",
			},
			automatic_installation = true,
		})
	end,
}
