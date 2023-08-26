local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local telescope_actions_setup, telescope_actions = pcall(require, "telescope.actions")
if not telescope_actions_setup then
	return
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = telescope_actions.move_selection_previous,
				["<C-j>"] = telescope_actions.move_selection_next,
				["<C-q>"] = telescope_actions.send_selected_to_qflist,
				-- Open file in current buffer window.
				["<Enter>"] = telescope_actions.select_default + telescope_actions.center,
			},
		},
	},
})

-- Use the telescope-fzf-native plugin (it now acts as the sorting algorithm)
-- The string 'fzf' is the extension modifier name
-- and we we cannot use 'telescope-fzf-native'
-- This is a convension that the Telescope project follows.
telescope.load_extension("fzf")
