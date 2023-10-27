local setup, lualine = pcall(require, "lualine")
if not setup then
	return
end

lualine.setup({
	options = {
		theme = "gruvbox_dark",
	},
})
