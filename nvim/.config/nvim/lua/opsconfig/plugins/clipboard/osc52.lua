return {
	-- NOTE:  Copies Neovim content to the system clipboard using the OSC52 protocol.
	--  Works seamlessly in remote terminals (SSH, tmux) without OS-level dependencies.
	--  Ideal for headless environments, WSL, and remote servers.
	--  Configurable with support for auto-selection and yank integration.
	--  Repository: https://github.com/ojroques/nvim-osc52
	"ojroques/nvim-osc52",

	event = "VeryLazy",

	config = function()
		local osc52 = require("osc52")

		osc52.setup({
			trim = false,
			tmux_passthrough = true,
		})

		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				if vim.v.event.operator == "y" and vim.v.event.regname == "" then
					if vim.g.opsconfig.global.is_servers then
						osc52.copy_register('"')
					else
						osc52.copy_register("+")
					end
				end
			end,
		})
	end,
}
