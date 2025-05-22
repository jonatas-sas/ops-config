vim.api.nvim_create_autocmd({
	"VimEnter",
	"BufReadPre",
	"BufNewFile",
}, {
	callback = function()
		vim.filetype.add({
			extension = {
				nginx = "nginx",
			},

			filename = {
				[".bashrc"] = "sh",
				[".projectrc"] = "sh",
				[".bash_custom"] = "bash",
				[".bash_logout"] = "bash",
				[".bash_ps1"] = "bash",
				[".bash_profile"] = "bash",
			},
		})
	end,
})
