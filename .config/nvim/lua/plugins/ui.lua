return {
	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- set to "tabs" to only show tabpages instead
					themable = false, -- allows highlight groups to be overriden i.e. sets highlights as default
					numbers = "none",
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "icon",
					},
					buffer_close_icon = "󰅖",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					--- name_formatter can be used to change the buffer's label in the bufferline.
					--- Please note some names can/will break the
					--- bufferline so use this at your discretion knowing that it has
					--- some limitations that will *NOT* be fixed.
					name_formatter = function(buf) -- buf contains:
						-- name                | str        | the basename of the active file
						-- path                | str        | the full path of the active file
						-- bufnr (buffer only) | int        | the number of the active buffer
						-- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
						-- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
					end,
					max_name_length = 18,
					max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
					truncate_names = true, -- whether or not tab names should be truncated
					tab_size = 18,
					diagnostics = "nvim_lsp", -- "nvim_lsp", "coc", "ale", "or null" so
					diagnostics_update_in_insert = "",
					-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						return "(" .. count .. ")"
					end,
					-- NOTE: this will be called a lot so don't do any heavy processing here
					custom_filter = function(buf_number, buf_numbers)
						-- filter out filetypes you don't want to see
						if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
							return true
						end
						-- filter out by buffer name
						if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
							return true
						end
						-- filter out based on arbitrary rules
						-- e.g. filter out vim wiki buffer from tabline in your work repo
						if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
							return true
						end
						-- filter out by it's index number in list (don't show first buffer)
						if buf_numbers[1] ~= buf_number then
							return true
						end
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "Neo-Tree", -- | function ,
							highlight = "Directory",
							text_align = "left", -- | "center" | "right"
							separator = true,
						},
					},
					color_icons = true,
					get_element_icon = function(element)
						-- element consists of {filetype: string, path: string, extension: string, directory: string}
						-- This can be used to change how bufferline fetches the icon
						-- for an element e.g. a buffer or a tab.
						-- e.g.
						local icon, hl =
							require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
						return icon, hl
					end,
					show_buffer_icons = true, -- disable filetype icons for buffers
					show_buffer_close_icons = true,
					show_close_icon = true,
					show_tab_indicators = true,
					show_duplicate_prefix = true, -- | false, -- whether to show duplicate buffer prefix
					duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
					persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
					move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
					-- can also be a table containing 2 custom separators
					-- [focused and unfocused]. eg: { '|', '|' }
					separator_style = "thin", -- | "slope" | "thick" | "thin" | { "any", "any" },
					enforce_regular_tabs = false,
					always_show_bufferline = true,
					auto_toggle_bufferline = true,
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
					sort_by = "insert_after_current",
					-- | "insert_at_end"
					-- | "id"
					-- | "extension"
					-- | "relative_directory"
					-- | "directory"
					-- | "tabs"
					-- | function(buffer_a, buffer_b)
					-- 	-- add custom logic
					-- 	return buffer_a.modified > buffer_b.modified
					-- end,
				},
			})
		end,
	},

	--Statusline (Lualine)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 1 } },
					},
					lualine_z = { { "location", padding = { left = 0, right = 1 } } },
				},
				extensions = { "neo-tree", "lazy" },
			})
		end,
	},

	-- Inent Blank Line
	{
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		config = function()
			require("ibl").setup()
		end,
	},

	--Neotree File Tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
		},
		opts = {
			filesystem = {
				window = {
					mappings = {
						["\\"] = "close_window",
					},
				},
			},
		},
	},

	--UndoTree
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
		end,
	},

	-- Better Vim Ui
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					-- Set to false to disable the vim.ui.input implementation
					enabled = true,

					-- Default prompt string
					default_prompt = "Input",

					-- Trim trailing `:` from prompt
					trim_prompt = true,

					-- Can be 'left', 'right', or 'center'
					title_pos = "left",

					-- When true, <Esc> will close the modal
					insert_only = true,

					-- When true, input will start in insert mode.
					start_in_insert = true,

					-- These are passed to nvim_open_win
					border = "rounded",
					-- 'editor' and 'win' will default to being centered
					relative = "cursor",

					-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					prefer_width = 40,
					width = nil,
					-- min_width and max_width can be a list of mixed types.
					-- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
					max_width = { 140, 0.9 },
					min_width = { 20, 0.2 },

					buf_options = {},
					win_options = {
						-- Disable line wrapping
						wrap = false,
						-- Indicator for when text exceeds window
						list = true,
						listchars = "precedes:…,extends:…",
						-- Increase this for more context when text scrolls off the window
						sidescrolloff = 0,
					},

					-- Set to `false` to disable
					mappings = {
						n = {
							["<Esc>"] = "Close",
							["<CR>"] = "Confirm",
						},
						i = {
							["<C-c>"] = "Close",
							["<CR>"] = "Confirm",
							["<Up>"] = "HistoryPrev",
							["<Down>"] = "HistoryNext",
						},
					},

					override = function(conf)
						-- This is the config that will be passed to nvim_open_win.
						-- Change values here to customize the layout
						return conf
					end,

					-- see :help dressing_get_config
					get_config = nil,
				},
				select = {
					-- Set to false to disable the vim.ui.select implementation
					enabled = true,

					-- Priority list of preferred vim.select implementations
					backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

					-- Trim trailing `:` from prompt
					trim_prompt = true,

					-- Options for telescope selector
					-- These are passed into the telescope picker directly. Can be used like:
					-- telescope = require('telescope.themes').get_ivy({...})
					telescope = nil,

					-- Options for fzf selector
					fzf = {
						window = {
							width = 0.5,
							height = 0.4,
						},
					},

					-- Options for fzf-lua
					fzf_lua = {
						-- winopts = {
						--   height = 0.5,
						--   width = 0.5,
						-- },
					},

					-- Options for nui Menu
					nui = {
						position = "50%",
						size = nil,
						relative = "editor",
						border = {
							style = "rounded",
						},
						buf_options = {
							swapfile = false,
							filetype = "DressingSelect",
						},
						win_options = {
							winblend = 0,
						},
						max_width = 80,
						max_height = 40,
						min_width = 40,
						min_height = 10,
					},

					-- Options for built-in selector
					builtin = {
						-- Display numbers for options and set up keymaps
						show_numbers = true,
						-- These are passed to nvim_open_win
						border = "rounded",
						-- 'editor' and 'win' will default to being centered
						relative = "editor",

						buf_options = {},
						win_options = {
							cursorline = true,
							cursorlineopt = "both",
						},

						-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
						-- the min_ and max_ options can be a list of mixed types.
						-- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
						width = nil,
						max_width = { 140, 0.8 },
						min_width = { 40, 0.2 },
						height = nil,
						max_height = 0.9,
						min_height = { 10, 0.2 },

						-- Set to `false` to disable
						mappings = {
							["<Esc>"] = "Close",
							["<C-c>"] = "Close",
							["<CR>"] = "Confirm",
						},

						override = function(conf)
							-- This is the config that will be passed to nvim_open_win.
							-- Change values here to customize the layout
							return conf
						end,
					},

					-- Used to override format_item. See :help dressing-format
					format_item_override = {},

					-- see :help dressing_get_config
					get_config = nil,
				},
			})
		end,
	},

	-- Which key
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			})
		end,
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
					signature = {
						enabled = false,
					},
					progress = {
						enabled = false,
					},
				},
				cmdline = {
					enabled = false,
				},
				messages = {
					enabled = false,
				},
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
				popupmenu = {
					enabled = false,
				},
				notify = { false },
			})
		end,
	},
}
