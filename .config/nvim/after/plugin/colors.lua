function ColorMyPencils(color)
	color = color or "github_dark_high_contrast"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
