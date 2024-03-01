vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-j>", "copilot#Next()", { expr = true, silent = true })
vim.keymap.set("i", "<C-k>", "copilot#Previous()", { expr = true, silent = true })

--vim.keymap.set("i", "<C-a>", "copilot#Accept(" < CR > ")", { expr = true, silent = true })
--Write me a neovim keymap to only accept one line of github copilot suggestions
vim.keymap.set("i", "<C-a>", "copilot#Accept()", { expr = true, silent = true })
