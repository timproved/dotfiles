require("lint").linters_by_ft = {
	markdown = { "vale" },
	c = { "cpplint" },
	python = { "mypy", "ruff" },
	java = { "checkstyle" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
