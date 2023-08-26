-- Setup LSP Saga.
-- Note that the original lspsaga repo was glepnir/lspsaga,
-- Now it's nvimdev/lspsaga
local lsp_saga_status, lsp_saga = pcall(require, "lspsaga")
if not lsp_saga_status then
  return
end


-- Setup lspsaga
-- Check https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
-- for some of the configuration options.
lsp_saga.setup({
  -- Keymapping for inside the LSP window
  definition = {
    keys = {
      edit = "<CR>",
    }
  },
})
