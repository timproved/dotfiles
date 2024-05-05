return {

	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile", "BufWritePost" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				-- java = { "google-java-format" },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = {},
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
			notify_on_error = true,
		})
		vim.keymap.set({ "n", "v" }, "<leader>fo", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				tmeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
