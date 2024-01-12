local nvim_lsplines_setup, nvim_lsplines = pcall(require, "lsp_lines")
if not nvim_lsplines_setup then
	return
end

nvim_lsplines.setup()

vim.diagnostic.config({
	virtual_text = false,
})
