local nvim_lspconfig_setup, nvim_lspconfig = pcall(require, "lspconfig")
if not nvim_lspconfig_setup then
	return
end

local cmp_nvim_lsp_setup, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_setup then
	return
end

local keymap = vim.keymap

-- Define keymappings for when a language server is attached to a buffer.
-- Whenever a file is being edited that as an associated LSP server (ie.
-- a Ruby/TypeScript file) then these keymappings will be "attached" to
-- the buffer and made available.
-- on_attach will be provided to each language server configuration below,
-- along with the nvim-cmp capabilities.
local on_attach = function(client, bufnr) -- bufnr stands for buffer number
	vim.api.nvim_out_write("LSP client attached to buffer " .. bufnr .. "\n")
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- Define keybinds
	-- Lspsaga keybinds
	keymap.set("n", "gf", vim.lsp.buf.references(), opts) -- show definition, references
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window

	keymap.set("n", "gD", vim.lsp.buf.definition(), opts) -- got to declaration
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- go to implementation

	-- Todo: Figure out
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
end

-- Set up capabilities.
--
-- Both the LSP client (in this case, Neovim) and the LSP server
-- must both inform each other of their capabilities, like autocompletion,
-- snippet support, etc.
--
-- Because there are so many different kinds of LSP servers (one or more
-- per language), and there are so many clients (editors/IDEs), we need
-- to do some initial configuration to ensure a smooth LSP experience.
--
-- For instance, if a language server doesn't support "rename symbol"
-- functionality, but the client does, knowing this in advance ensures
-- that the client won't offer a broken feature to the end user.
--
-- For example in our case, we're using nvim-cmp, so we need to inform the language
-- server that we are using nvim-cmp, so that it can be aware of its capabilities.
-- The server will then let Neovim know what it itself is capable of, and then where
-- nvim-cmp (what Neovim is using) and the LSP server intersect is what capabilities
-- will be used.
--
-- To summarize:
-- The language server will only offer features that it can support.
-- The client (editor/IDE) will only request or use features that both it can
-- handle and that the server has offered (i.e., stated it supports).
--
-- So, if a language server has a feature but the client doesn't support it,
-- that feature won't be used. Conversely, if the client supports a feature
-- but the language server doesn't, the client won't try to use that feature
-- with that particular server.
--
-- It's a way of ensuring that both parties speak the same "language" in
-- terms of capabilities, optimizing the user experience.

-- So first, get nvim-cmp's capabilities.
local nvim_cmp_capabilities = cmp_nvim_lsp.default_capabilities()

-- Now, configure each language server with the capabilities and the
-- keybindings when the language server attaches to the buffer.

-- Ruby.
nvim_lspconfig.solargraph.setup({
	capabilities = nvim_cmp_capabilities,
	on_attach = on_attach,
})

-- HTML.
nvim_lspconfig.html.setup({
	capabilities = nvim_cmp_capabilities,
	on_attach = on_attach,
})

-- TypeScript
nvim_lspconfig.tsserver.setup({
	capabilities = nvim_cmp_capabilities,
	on_attach = on_attach,
})

-- CSS
nvim_lspconfig.cssls.setup({
	capabilities = nvim_cmp_capabilities,
	on_attach = on_attach,
})

-- Lua
-- This requires some extra configuration.
nvim_lspconfig.lua_ls.setup({
	capabilities = nvim_cmp_capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

vim.lsp.set_log_level("debug")
