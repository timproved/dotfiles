local M = {}

M.on_attach = function(client, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end
end

M.defaults = function()
	require("lspconfig").pyright.setup({
		on_attach = M.on_attach,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	})
	require("lspconfig").ruff_lsp.setup({
		on_attach = M.on_attach,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	})
end

return M
