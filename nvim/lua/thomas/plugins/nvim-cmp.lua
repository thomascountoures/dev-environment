-- Setup Autocomplete and Snippets.
-- Things to note:
-- 1. Nvim CMP is the main auto complete engine.
-- 2. Luasnip is the main snippets engine.
-- 3. CMP luasnip is the bridge between nvim-cmp and luasnip. It lets the completion
-- engine know about the snippets and provide autocomplete suggestions for them.
-- 4. Nvim CMP uses cmp-path and cmp-buffer as extra sources of autocompletion suggestions.
-- For example cmp-path sources your local filesystem and provides suggestions based on that.
-- cmp-buffer pulls suggestions from current and other open buffers (files).

-- first, ensure nvim cmp was already installed.
-- Note that we need to use the name of the plugin which is nvim_cmp.lua
-- and can be shortened to cmp. (this is a design decision of the plugin author).
local nvim_cmp_setup, nvim_cmp = pcall(require, "cmp")
if not nvim_cmp_setup then
  return
end

-- second, ensure luasnip was already installed.
local luasnip_setup, luasnip = pcall(require, "luasnip")
if not luasnip_setup then
  return
end

-- third, ensure lspkind (vs code pictograph icons for auto complete)
-- was already installed.
local lspkind_setup, lspkind = pcall(require, "lspkind")
if not lspkind_setup then
  return
end

-- setup nvim cmp
nvim_cmp.setup({
  -- the snippet/expand inner details here are from the nvim cmp github README - https://github.com/hrsh7th/nvim-cmp
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- this is the specified config from the repo for luasnip
    end
  },
  -- shortcuts for selecting autocomplete suggestions
  mapping = nvim_cmp.mapping.preset.insert({
    ["<C-k>"] = nvim_cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = nvim_cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = nvim_cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = nvim_cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = nvim_cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = nvim_cmp.mapping.abort(), -- close completion window
    ["<CR>"] = nvim_cmp.mapping.confirm({ select = false }),
  }),
  -- sources for autocompletion
  sources = nvim_cmp.config.sources({
    { name = "nvim_lsp" }, -- lsp
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
  }),
  -- Specifically for lspkind.
  -- See https://github.com/onsails/lspkind.nvim
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    })
  }
})
