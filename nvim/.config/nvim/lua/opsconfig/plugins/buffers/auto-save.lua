return {
	-- NOTE:  Enables automatic saving in Neovim.
	--  Automatically saves the buffer when certain events occur (e.g., InsertLeave, TextChanged).
	--  Prevents data loss and improves productivity by reducing the need for manual saves.
	--  Fully customizable, supports conditions, exclusions, debounce delay, and custom triggers.
	--  Repository: https://github.com/okuuva/auto-save.nvim
	"okuuva/auto-save.nvim",

	cmd = "ASToggle",

	event = {
		"InsertLeave",
		"TextChanged",
	},

	config = function()
		local autosave = require("auto-save")
		local autosave_status = true

		-- User Commands {{{

		local function toggle_autosave()
			autosave.toggle()

			autosave_status = not autosave_status

			local msg = autosave_status and "󰄬 AutoSave Ativado" or "󰅙 AutoSave Desativado"

			vim.notify(msg, vim.log.levels.INFO, { title = "AutoSave" })
		end

		vim.api.nvim_create_user_command("AutoSaveToggleNotify", toggle_autosave, {})

		-- }}}

		-- Statusline {{{

		_G.autosave_statusline = function()
			return autosave_status and "󰄬 AutoSave" or "󰅙 AutoSave"
		end

		-- }}}

		-- Setup {{{

		autosave.setup({
			enabled = true,
			write_all_buffers = false,
			noautocmd = false,
			lockmarks = false,
			debounce_delay = 2000,
			debug = false,

			trigger_events = {
				immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },

				defer_save = {
					"InsertLeave",
					"TextChanged",
					{ "User", pattern = "VisualLeave" },
					{ "User", pattern = "FlashJumpEnd" },
					{ "User", pattern = "SnacksInputLeave" },
					{ "User", pattern = "SnacksPickerInputLeave" },
				},

				cancel_deferred_save = {
					"InsertEnter",
					{ "User", pattern = "VisualEnter" },
					{ "User", pattern = "FlashJumpStart" },
					{ "User", pattern = "SnacksInputEnter" },
					{ "User", pattern = "SnacksPickerInputEnter" },
				},
			},

			condition = function(buf)
				if vim.fn.mode() == "i" then
					return false
				end

				if require("luasnip").in_snippet() then
					return false
				end

				local blocked_filetypes = {
					"neo-tree", -- NeoTree file explorer
					"oil", -- oil.nvim file explorer
					"TelescopePrompt", -- Telescope prompt
					"lazy", -- lazy.nvim UI
					"lazygit", -- lazygit.nvim UI
					"toggleterm", -- toggleterm terminal buffer
					"OverseerList", -- overseer.nvim task manager
					"qf", -- quickfix window
					"diff", -- diff view
					"fugitive", -- fugitive buffers (caso use)
					"notify", -- nvim-notify (noice)
					"snacks_input", -- input temporário (custom plugin)
					"snacks_picker_input",
					"noice", -- noice.nvim popup
					"dap-repl", -- DAP REPL
					"dapui_watches", -- DAP UI
					"dapui_stacks",
					"dapui_breakpoints",
					"dapui_scopes",
					"dapui_console",
					"copilot-chat", -- caso use copilot-chat
					"gitcommit", -- mensagem de commit
					"sql", -- buffers SQL (evita salvar e rodar acidentalmente)
					"mysql", -- idem acima
					"harpoon", -- harpoon buffer
					"markdown", -- caso use render-markdown com buffer temporário
				}

				local ft = vim.bo[buf].filetype

				if vim.tbl_contains(blocked_filetypes, ft) then
					return false
				end

				return true
			end,

			callbacks = {
				before_saving = function()
					vim.notify("󱂬 Salvando...", vim.log.levels.INFO, { title = "AutoSave", timeout = 300 })
				end,

				after_saving = function()
					vim.notify("󰄬 Salvo com sucesso", vim.log.levels.INFO, { title = "AutoSave", timeout = 1000 })
				end,
			},
		})

		-- }}}

		-- Keymaps {{{

		local wk = require("which-key")

		wk.add({
			{
				"<leader>ua",
				"<cmd>AutoSaveToggleNotify<CR>",
				desc = "󱂬 Alternar AutoSave",
				icon = { color = "cyan", icon = "󱂬" },
				mode = "n",
				noremap = true,
				silent = true,
			},
		})

		-- }}}
	end,
}
