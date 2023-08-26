local nvim_autopairs_setup, nvim_autopairs = pcall(require, "nvim-autopairs")
if not nvim_autopairs_setup then
	return
end

-- Setup autopairs to use Treesitter.
-- Integrating with Treesitter supercharges
-- its capabilities, making the autopairing
-- more accurate and contextually aware as it
-- uses Treesitter's syntax tree of the
-- source code.
nvim_autopairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
		java = false, -- don't check treesitter on java
	},
})
