return {

	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile", "BufWritePost" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				["javascript"] = { "prettier" },
				["javascriptreact"] = { "prettier" },
				["typescript"] = { "prettier" },
				["typescriptreact"] = { "prettier" },
				["css"] = { "prettier" },
				["scss"] = { "prettier" },
				["less"] = { "prettier" },
				["html"] = { "prettier" },
				["json"] = { "prettier" },
				["jsonc"] = { "prettier" },
				["yaml"] = { "prettier" },
				["markdown"] = { { "prettierd", "prettier" }, "markdownlint", "markdown-toc" },
				["markdown.mdx"] = { { "prettierd", "prettier" }, "markdownlint", "markdown-toc" },
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
