vim.g.mapleader = " "
--UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndoTreeToggle, { desc = "Toggle UndoTree" })
--vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "NetRW me daddy" })
-- Jump up and down stay centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up, Jump up, " })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--yank that shit
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })
--VSWho?
vim.keymap.set("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
--Buffers
vim.api.nvim_set_keymap("n", "<S-h>", ":bprevious<enter>", { noremap = false, desc = "jump top previous buffer" })
vim.api.nvim_set_keymap("n", "<S-l>", ":bnext<enter>", { noremap = false, desc = "jump to next buffer" })
vim.api.nvim_set_keymap("n", "<C-c>", ":bdelete<enter>", { noremap = false, desc = "delete this buffer" })
--DAP Stuff
vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")
vim.keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>")
--Trouble
vim.keymap.set("n", "<leader>tt", function()
	require("trouble").toggle()
end, { desc = "Toggle Trouble" })
vim.keymap.set("n", "<leader>tw", function()
	require("trouble").toggle("workspace_diagnostics")
end, { desc = "Toggle Trouble Workspace Diagnostics" })
vim.keymap.set("n", "<leader>td", function()
	require("trouble").toggle("document_diagnostics")
end, { desc = "Toggle Trouble Document Diagnostics" })
-- Disable arrow keys
vim.api.nvim_set_keymap("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Right>", "<Nop>", { noremap = true, silent = true })
