return {
		{
			"mfussenegger/nvim-lint",
			event = {
				"BufReadPre",
				"BufNewFile",
			},
			config = function()
				local lint = require("lint")
				lint.linters_by_filetype = {
					python = { "mypy", "ruff" },
					markdown = { "markdownlint" },
					dockerfile = { "hadolint" },
				}

				-- vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				-- 	group = lint_augroup,
				-- 	callback = function()
				-- 		lint.try_lint()
				-- 	end,
				-- })
			end,
		},
}
