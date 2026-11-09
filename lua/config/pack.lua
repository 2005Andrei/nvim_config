vim.pack.add({
	{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/brenoprata10/nvim-highlight-colors" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	-- { src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/idossha/matlab.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/nvimdev/dashboard-nvim" },
	{ src = "https://github.com/ojroques/nvim-bufdel" },

	-- notifcations
	{ src = "https://github.com/rcarriga/nvim-notify" },

	-- typst
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },

	-- lsp
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	-- for tsx
	{ src = "https://github.com/Saghen/blink.cmp", version = "v0.11.0" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },

	-- telescope
	{ src = "http://github.com/aznhe21/actions-preview.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/LinArcX/telescope-env.nvim" },
	{ src = "https://github.com/nvim-lua/popup.nvim" },

	-- dap
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },

	-- dependencies added as normal plugins
	{ src = "https://github.com/3rd/image.nvim" },
	{ src = "https://github.com/antosha417/nvim-lsp-file-operations" },
	{ src = "https://github.com/s1n7ax/nvim-window-picker" },

	-- keep buffer sizes
	{ src = "https://github.com/kwkarlwang/bufresize.nvim" },

	-- nvim minimap, preview images in neeovim
	{ src = "https://github.com/Isrothy/neominimap.nvim" },
	{ src = "https://github.com/3rd/image.nvim" },

	-- compiler
	{ src = "https://github.com/Zeioth/compiler.nvim" },
	{ src = "https://github.com/stevearc/overseer.nvim" },

	-- jupynium, ipybrn
	{ src = "https://github.com/kiyoon/jupynium.nvim" },
	-- { src = "https://github.com/ajbucci/ipynb.nvim" },

	-- markdown renderer
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

require("notify").setup({})
require("dapui").setup()
vim.notify = require("notify")

vim.keymap.set("n", "<leader>b", function()
	local bufs = vim.api.nvim_list_bufs()
	local clean_list = {}

	for _, buf_id in ipairs(bufs) do
		if vim.fn.buflisted(buf_id) == 1 then
			local path = vim.api.nvim_buf_get_name(buf_id)

			if path == "" then
				path = "[no name]"
			else
				path = vim.fn.fnamemodify(path, ":~:.")
			end

			table.insert(clean_list, buf_id .. " " .. path)
		end
	end

	vim.notify(clean_list, "utility", {
		title = "buffers",
	})
end, { desc = "list buffers" })

require("bufdel").setup({
	next = "tabs",
	quit = true,
})

-- :lua vim.print(vim.fn.api_info().types)
vim.keymap.set("n", "<leader>c", function()
	local buffer = vim.api.nvim_exec2("reg", { output = true })
	local clean_buffer = {}

	for str in string.gmatch(buffer.output, "[^\r\n]+") do
		if not string.match(str, "^%-%-%-") then
			local squeezed = string.gsub(str, "%s+", " ")

			if string.len(squeezed) < 30 then
				table.insert(clean_buffer, squeezed)
			else
				table.insert(clean_buffer, string.sub(squeezed, 1, 30) .. "...")
			end
		end
	end

	vim.notify(clean_buffer, "utility", {
		title = "clipboard",
	})
end, { desc = "Show clipboard a bit nicer" })

require("vague").setup({
	transparent = true,
	bold = false,
	italic = false,
})

require("kanagawa").setup({
	transparent = true,

	overrides = function(colors)
		local theme = colors.theme
		return {
			TabLine = { bg = "none" },
			TabLineFill = { bg = "none" },
			TabLineSel = { bg = "none" },

			BufferLineFill = { bg = "none" },
			BufferLineBackground = { bg = "none" },

			LineNr = { bg = "none" },
			CursorLineNr = { bg = "none" },
			SignColumn = { bg = "none" },
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },

			NeoTreeNormal = { bg = "none" },
			NeoTreeNormalNC = { bg = "none" },

			-- ref: https://github.com/NvChad/base46/blob/v3.0/lua/base46/integrations/telescope.lua
			TelescopeSelection = { bg = "none", fg = "beige" },
			TelescopeBorder = { bg = "none", fg = "none" },
			TelescopePromptPrefix = { bg = "none", fg = "NvimLightBlue" },
			TelescopePreviewBorder = { bg = "none", fg = "beige" },
			TelescopeResultsTitle = { bg = "none", fg = "NvimLightBlue" },
			TelescopePreviewTitle = { bg = "none", fg = "NvimLightBlue" },
			TelescopePromptTitle = { bg = "none", fg = "NvimLightBlue" },

			DashboardHeader = { bg = "none", fg = "#61afef" },
		}
	end,
})

-- source: https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/slanted-gaps.lua

local colors = {
	red = "#ca1243",
	grey = "#a0a1a7",
	black = "#383a42",
	white = "#f3f3f3",
	light_green = "#83a598",
	orange = "#fe8019",
	green = "#8ec07c",
	dark_blue = "#2D4F67",
	gray = "#d3d3d3",
}

local function process_sections(sections)
	for name, section in pairs(sections) do
		local left = name:sub(9, 10) < "x"
		for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
			table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.black } })
		end
		for id, comp in ipairs(section) do
			if type(comp) ~= "table" then
				comp = { comp }
				section[id] = comp
			end
			comp.separator = left and { right = "" } or { left = "" }
		end
	end
	return sections
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "kanagawa-dragon",
		component_separators = "",
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16,
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				"branch",
				separator = { right = "" },
			},
			{
				"diff",
				colored = true,
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				color = { bg = colors.dark_blue },
				symbols = { added = "+", modified = "~", removed = "-" },
				source = "git",
				separator = { left = "", right = "" },
			},
			{
				"diagnostics",
				source = { "nvim" },
				sections = { "error" },
				diagnostics_color = { warn = { fg = colors.red, bg = colors.black } },
			},
			{
				"diagnostics",
				source = { "nvim" },
				sections = { "warn" },
				diagnostics_color = { warn = { fg = colors.orange, bg = colors.black } },
			},
		},
		lualine_c = {
			{
				"filename",
				path = 3,
				color = { fg = "#c5c9c5", bg = "#181616" },
				separator = { left = "", right = "" },
			},
		},
		lualine_x = {
			{
				"encoding",
				color = { fg = "#c5c9c5", bg = "#282727" },
				separator = { left = "", right = "" },
			},
			{
				"fileformat",
				color = { bg = colors.grey, fg = "#2D4F67" },
				separator = { left = "", right = "" },
			},
			{
				"filetype",
				color = { fg = colors.gray, bg = colors.black },
				separator = { left = "", right = "" },
			},
		},
		lualine_y = {},
		lualine_z = {
			{
				"datetime",
				style = "%H:%M",
				separator = { left = "", right = "" },
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

vim.cmd("colorscheme kanagawa-dragon")

local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = { treesitter = true },
		color_devicons = true,
		sorting_strategy = "ascending",
		-- borderchars = {
		-- 	top
		-- 	right
		-- 	bottom
		--  left
		--  top-left
		--  top-right
		--  bottom-right
		--  bottom-left
		-- }

		prompt_prefix = "❯ ",
		selection_caret = "* ",
		-- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 500,
			prompt_position = "top",
			preview_cutoff = 40,
		},

		layout_strategy = "flex",
	},
})
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope Find Files" })
vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Telescope Find String" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help" })
vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Telescope Man Pages" })
vim.keymap.set("n", "<leader>fe", "<Cmd>Telescope env<CR>", { desc = "env vars" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "diagnostics" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "keymaps" })
vim.keymap.set("n", "<leader>fn", ":Telescope notify<Cr>", { desc = "notification history" })

vim.keymap.set("n", "<leader>fl", builtin.git_bcommits, { desc = "git commits" })

require("actions-preview").setup({
	backend = { "telescope" },
	extensions = { "env" },
	telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {}),
})

require("oil").setup({
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	view_options = {
		show_hidden = true,
	},
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>")

require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,

	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 1,
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			with_expanders = nil,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "e",
			default = "*",
			highlight = "NeoTreeFileIcon",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				added = "",
				modified = "",
				deleted = "✖",
				renamed = "󰁕",
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
	},

	window = {
		position = "left",
		width = 30,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false,
			},
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["<esc>"] = "cancel",
			["P"] = { "toggle_preview", config = { use_float = true } },
			["l"] = "open",
			["S"] = "open_split",
			["s"] = "open_vsplit",
			["z"] = "close_all_nodes",
			["Z"] = "expand_all_nodes",
		},
	},

	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_hidden = true,
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		group_empty_dirs = true,
		hijack_netrw_behavior = "open_default",
		use_libuv_file_watcher = true,
	},
})

require("bufferline").setup({
	-- transparency
	highlights = {
		background = { bg = "none" },
		fill = { bg = "none" },
		buffer_selected = { bg = "none", fg = "#fab387" },
		buffer_visible = { bg = "none", fg = "#a6adc8" },
		close_button = { bg = "none" },
		close_button_selected = { bg = "none" },
		close_button_visible = { bg = "none" },
		duplicate = { bg = "none" },
		duplicate_selected = { bg = "none" },
		duplicate_visible = { bg = "none" },
		error = { bg = "none" },
		error_selected = { bg = "none" },
		error_visible = { bg = "none" },
		hint = { bg = "none" },
		hint_selected = { bg = "none" },
		hint_visible = { bg = "none" },
		indicator_selected = { bg = "none" },
		indicator_visible = { bg = "none" },
		info = { bg = "none" },
		info_selected = { bg = "none" },
		info_visible = { bg = "none" },
		modified = { bg = "none" },
		modified_selected = { bg = "none" },
		modified_visible = { bg = "none" },
		numbers = { bg = "none" },
		numbers_selected = { bg = "none" },
		numbers_visible = { bg = "none" },
		offset_separator = { bg = "none" },
		pick = { bg = "none" },
		pick_selected = { bg = "none" },
		pick_visible = { bg = "none" },
		separator = { bg = "none" },
		separator_selected = { bg = "none" },
		separator_visible = { bg = "none" },
		tab = { bg = "none" },
		tab_close = { bg = "none" },
		tab_selected = { bg = "none" },
		tab_separator = { bg = "none" },
		tab_separator_selected = { bg = "none" },
		trunc_marker = { bg = "none" },
		warning = { bg = "none" },
		warning_selected = { bg = "none" },
		warning_visible = { bg = "none" },
	},
	options = {
		indicator = {
			icon = "",
			style = "none",
		},
		separator_style = { "", "" },
	},
})

require("typst-preview").setup({
	dependencies_bin = {
		["tinymist"] = "tinymist",
	},
})

require("dashboard").setup({
	theme = "doom",
	config = {
		vertical_center = true,
		horizontal_center = true,
		header = {
			"",
			"",
			"Get good",
			"",
			"No excuses",
			"",
		},
		center = {
			{
				action = "Telescope find_files",
				desc = " Find File",
				icon = " ",
				key = "f",
				key_hl = "Number",
				desc_hl = "String",
				icon_hl = "Title",
			},
			{
				action = "ene | startinsert",
				desc = " New File",
				icon = " ",
				key = "n",
				key_hl = "Number",
				desc_hl = "String",
				icon_hl = "Title",
			},
			{
				action = "Telescope oldfiles",
				desc = " Recent Files",
				icon = " ",
				key = "r",
				key_hl = "Number",
				desc_hl = "String",
				icon_hl = "Title",
			},
			{
				action = "Telescope live_grep",
				desc = " Find Text",
				icon = " ",
				key = "g",
				key_hl = "Number",
				desc_hl = "String",
				icon_hl = "Title",
			},
			{
				action = "qa",
				desc = " Quit Neovim",
				icon = " ",
				key = "q",
				key_hl = "Number",
				desc_hl = "String",
				icon_hl = "Title",
			},
		},
		footer = {
			"",
			"Neovim loaded",
		},
	},
})

require("nvim-autopairs").setup({})
require("ibl").setup({
	exclude = {
		filetypes = {
			"dashboard",
			"neo-tree",
			"trouble",
			"lazy",
			"mason",
		},
	},
})
require("mason").setup({})

-- require("nvim-ts-autotag").setup({
-- 	opts = {
-- 		enable_close = true,
-- 		enable_rename = true,
-- 		enable_close_on_slash = true,
-- 	},
-- 	aliases = {
-- 		["axaml"] = "xml",
-- 	},
-- })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cs = { "csharpier" },
		cpp = { "clang-format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		xml = { "xmllint" },
		qml = { "qmlformat" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
	formatters = {
		xmllint = {
			env = {
				XMLLINT_INDENT = "    ",
			},
		},
	},
})

require("bufresize").setup({
	register = {
		keys = {
			{ "n", "<leader>r<", "30<C-w><", { noremap = true, silent = true } },
			{ "n", "<leader>r>", "30<C-w>>", { noremap = true, silent = true } },
			{ "n", "<leader>rp", "10<C-w>+", { noremap = true, silent = true } },
			{ "n", "<leader>rm", "10<C-w>-", { noremap = true, silent = true } },
			{ "n", "<leader>r_", "<C-w>_", { noremap = true, silent = true } },
			{ "n", "<leader>r=", "<C-w>=", { noremap = true, silent = true } },
			{ "n", "<leader>r|", "<C-w>|", { noremap = true, silent = true } },
			{ "n", "<leader>ro", "<C-w>|<C-w>_", { noremap = true, silent = true } },
		},
	},
	resize = {
		keys = {},
		trigger_event = { "VimResized" },
		increment = 10,
	},
})

require("overseer").setup({})
require("compiler").setup({})

vim.api.nvim_set_keymap("n", "<leader>oc", "<cmd>CompilerOpen<Cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-c>", "<cmd>compilerStop<Cr>", { noremap = true, silent = true })

-- vim.api.nvim_create_autocmd("CompilerMakeSolution", {
-- 	callback = function(args)
-- 		-- todo: add solution builder with custom commmands
-- 		vim.notify("to do")
-- 	end,
-- })

require("blink.cmp").setup({
	keymap = {
		preset = "default",

		["<Tab>"] = { "accept", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<CR>"] = { "fallback" },

		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	signature = { enabled = true },
	completion = {
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon
							if ctx.item.source_name == "LSP" then
								local color_item =
									require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr ~= "" then
									icon = color_item.abbr
								end
							end
							return icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							local highlight = "BlinkCmpKind" .. ctx.kind
							if ctx.item.source_name == "LSP" then
								local color_item =
									require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr_hl_group then
									highlight = color_item.abbr_hl_group
								end
							end
							return highlight
						end,
					},
				},
			},
		},
	},
})

require("nvim-highlight-colors").setup({
	render = "virtual",
	virtual_symbol_position = "inline",
	enable_hex = true,
	enable_rgb = true,
	enable_hsl = true,
	enable_ansi = true,
	enable_tailwind = true,
})
-- lsp config

vim.treesitter.language.register("c_sharp", "cs")
vim.treesitter.language.register("qmljs", "qml")

vim.lsp.enable({
	"lua_ls",
	"cssls",
	"tinymist",
	"clangd",
	"ruff",
	"tailwindcss",
	"ts_ls",
	"pyright",
	"matlab_ls",
	"csharp_ls",
})

-- qml setup
vim.lsp.config.qml = {
	cmd = { "qml-language-server" },
	filetypes = { "qml" },
	root_markers = { "qmldir", ".git" },
}

vim.lsp.enable("qml")

local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config("tinymist", {
	capabilities = capabilities,
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onType",
		semanticTokens = "disable",
		formatterProseWrap = true,
		format_on_save = true,
		formatterIndentSize = 4,
		-- outputPath = "$root/$dir/pdf/$name",
	},
})

capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	settings = {
		javascript = {
			suggest = {
				autoImports = true,
			},
		},
		typescript = {
			suggest = {
				autoImports = true,
			},
			preferences = {
				includePackageJsonAutoImports = "auto",
			},
		},
	},
})

vim.lsp.config("tailwindcss", {
	capabilities = capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set(
			"n",
			"gd",
			require("telescope.builtin").lsp_definitions,
			vim.tbl_extend("force", opts, { desc = "LSP Go to definition" })
		)
		vim.keymap.set(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			vim.tbl_extend("force", opts, { desc = "Go to declaration" })
		)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
		vim.keymap.set("n", "<leader>fn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		vim.keymap.set(
			{ "n", "v" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "Code action" })
		)
	end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("my.lsp", {}),
-- 	callback = function(args)
-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
-- 		if client:supports_method("textDocument/completion") then
-- 			local chars = {}
-- 			for i = 32, 126 do
-- 				table.insert(chars, string.char(i))
-- 			end
-- 			client.server_capabilities.completionProvider.triggerCharacters = chars
-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
-- 		end
--
-- 		local opts = { buffer = args.buf, desc = "LSP Go to definition" }
-- 		vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
-- 		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "go to definition" })
-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "hover docs" })
-- 		vim.keymap.set("n", "<leader>fn", vim.lsp.buf.rename, { buffer = args.buf, desc = "rename symbol" })
-- 		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "code action" })
-- 	end,
-- })

vim.keymap.set("n", "<leader>e", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end, { desc = "neotree explorer" })

-- vim.keymap.set(modes, "<leader>o", function()
-- 	if vim.bo.filetype == "neo-tree" then
-- 		vim.cmd.wincmd("p")
-- 	else
-- 		vim.cmd.Neotree("focus")
-- 	end
-- end, { desc = "toggle focus" })

-- matlab
require("matlab").setup({
	executable = "/home/andrei/.local/MATLAB/R2025b/bin/matlab",

	panel_size = 50,
	panel_size_type = "percentage",
	tmux_pane_direction = "right",
	tmux_pane_focus = true,

	auto_start = true,
	default_mappings = true,
	minimal_notifications = true,
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.adapters.coreclr = {
	type = "executable",
	command = "/usr/bin/netcoredbg",
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/*.dll", "file")
		end,
	},
}

vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "DAP Continue" })
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F1>", function()
	require("dap").step_into()
end, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F9>", function()
	require("dap").toggle_breakpoint()
end, { desc = "DAP Breakpoint" })

require("jupynium").setup({})
-- require("ipynb").setup({
-- 	kernel = {
-- 		python_path = "/usr/bin/python3",
-- 	},
-- })

vim.g.neominimap = {
	auto_enable = true,

	exclude_filetypes = {
		"",
		"alpha",
		"dashboard",
		"starter",
		"lazy",
		"mason",
		"help",
		"neo-tree",
		"NvimTree",
		"TelescopePrompt",
		"txt",
	},

	exclude_buftypes = {
		"nofile",
		"nowrite",
		"quickfix",
		"terminal",
		"prompt",
	},
}

vim.keymap.set("n", "<leader>z", "<Cmd>Neominimap TabToggle<Cr>", { desc = "toggle minimap" })

require("image").setup({
	dependencies = { "luarocks.nvim" },
	opts = {},
	integrations = {
		typst = {
			enabled = false,
		},
	},
})

require("render-markdown").setup({})
