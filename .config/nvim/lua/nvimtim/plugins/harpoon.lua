return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():append()
			end, { desc = "Add File to Harpoon list" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Toggle Harpoon list" })

			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():select(1)
			end, { desc = "Select Harpoon list 1" })
			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end, { desc = "Select Harpoon list 2" })
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end, { desc = "Select Harpoon list 3" })
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(4)
			end, { desc = "Select Harpoon list 4" })
		end,
	},
}
