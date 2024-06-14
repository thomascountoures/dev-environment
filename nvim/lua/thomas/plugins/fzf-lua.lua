local status_ok, fzf_lua = pcall(require, "fzf-lua")
if not status_ok then
	return
end

fzf_lua.setup({})
fzf_lua.setup_fzfvim_cmds()

vim.api.nvim_create_user_command("Rg", function(opts)
	require("fzf-lua").grep({
		search = opts.args,
	})
end, { nargs = "*" })
