local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended configuration from the nvim-tree github README (https://github.com/nvim-tree/nvim-tree.lua)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- setup nvim-tree
nvimtree.setup({
	-- change folder arrow icons
	view = {
		width = 50,
	},
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
