vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps

-- remap escape key to tab while in insert mode
keymap.set("i", "jw", "<ESC>")

keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Don't put deleted characters in the register (put in "Black Hole" register)
keymap.set("n", "x", '"_x')

-- Remap number incrementer and decrementer commands
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- Split window remaps
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- Tab remaps
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- Specifically for the vim-maximizer plugin
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- Remap nvim tree toggle because :NvimTreeToggle is annoying
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fs", ":Telescope grep_string<CR>")
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")

-- To Trim Freakin' Whitespaces.
keymap.set("n", "<leader>tw", "<cmd>%s/\\s\\+$//e<CR>")

-- Get rid of highlighting upon hitting enter.
keymap.set("n", "<CR>", "<cmd>noh<CR>")
