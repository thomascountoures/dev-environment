-- Sets up mason.nvim and mason_lspconfig
-- check if mason is installed
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

-- check if mason_lspconfig is installed
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  return
end

mason.setup()
mason_lspconfig.setup({
  -- check https://github.com/williamboman/mason-lspconfig.nvim if you want to add/update more LSP servers
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "lua_ls",
    "solargraph"
  }
})

-- I couldn't find the available sources on the mason_null_ls
-- repo. Instead check https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
-- for some of the available sources on the null_ls formatting and
-- diagnotics tables in the associated directories.
mason_null_ls.setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d"
  }
})


