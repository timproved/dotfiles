return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		-- get access to the none-ls functions
		local null_ls = require("null-ls")
		-- run the setup function for none-ls to setup our different formatters
		null_ls.setup({
			sources = {
				-- Lua:
				null_ls.builtins.formatting.stylua,
				-- TS / JS
				require("none-ls.diagnostics.eslint_d"),
				-- setup prettier to format languages that are not lua
				null_ls.builtins.formatting.prettierd.with({
					extra_args = function(params)
						return params.options
							and params.options.tabSize
							and {
								"--tab-width",
								params.options.tabSize,
							}
					end,
				}),
				-- Docker
				null_ls.builtins.diagnostics.hadolint,
				-- Markdown
				null_ls.builtins.diagnostics.markdownlint,
				-- Python:
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.formatting.isort,
				--Java
				-- null_ls.builtins.formatting.google_java_format.with({
				-- 	extra_args = function(params)
				-- 		return params.options
				-- 			and params.options.tabSize
				-- 			and {
				-- 				"--tab-width",
				-- 				params.options.tabSize,
				-- 			}
				-- 	end,
				-- }),
				-- C / CPP
				null_ls.builtins.formatting.clang_format,
			},
		})
		vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format, { desc = "[F]ormat" })
		-- Format on Save:
		local format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = format_augroup,
			callback = function()
				vim.lsp.buf.format({ async = true })
			end,
		})
	end,
}
