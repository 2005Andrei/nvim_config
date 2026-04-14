vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.g.loaded_netrw = 1
vim.g.loadeed_netrwPlugin = 1
vim.cmd([[set mouse=]])

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 200
vim.opt.fillchars = { eob = " " } -- disable the ugly ~ at the end of buffers

vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250,r-cr:hor20,o:hor50,a:Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})

-- primagen mappings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })

-- resize windowa
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- not lose selection after indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- more clipboard keymaps
local opts = { noremap = true, silent = true }
local modes = { "n", "v", "x" }
vim.keymap.set(modes, "yag", ":%y<CR>", opts)
vim.keymap.set(modes, "vag", "ggVG", opts)
vim.keymap.set(modes, "gl", "$", { desc = "jump to the end of line" })
vim.keymap.set(modes, "n", "nzzzv")
vim.keymap.set(modes, "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "<ESC>", "<CMD>nohlsearch<CR><ESC>", { desc = "Clear highlights and escape" })
vim.keymap.set(modes, "<leader>r", ":so<CR>", { desc = "reload config" })
vim.keymap.set(modes, "<leader>R", ":restart<CR>", { desc = "restart nvim" })
vim.keymap.set(modes, "<C-y>", '"+y', { desc = "system clipboard yank" })
vim.keymap.set(modes, "<C-p>", '"*p', { desc = "system clipboard put" })

vim.keymap.set({ "n" }, "<leader>w", "<Cmd>:w<CR>", { desc = "write" })
vim.keymap.set({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "quit" })
vim.keymap.set({ "n" }, "<leader>W", "<Cmd>:wa<CR>", { desc = "write all" })
vim.keymap.set({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "write quit all" })

vim.keymap.set("n", "<C-e>", function()
	vim.system({ "xdg-open", "." })
end, { desc = "open current folder in file explorer" })

-- vim.keymap.set("n", "<leader>sh", builtin.help_tags)
-- vim.keymap.set("n", "<leader>sm", builtin.man_pages)
-- vim.keymap.set({ "n" }, "<leader>sr", builtin.lsp_references)
-- vim.keymap.set({ "n" }, "<leader>sd", builtin.Diagnostics)

for i = 1, 8 do
	vim.keymap.set({ "n", "t" }, "<leader>" .. i, "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>")
end

-- file types
vim.filetype.add({
	extension = {
		xaml = "xml",
		axaml = "xml",
		typ = "typst",
		qml = "qml",
	},
})

vim.api.nvim_create_user_command("OpendPdf", function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath:match("%.typ$") then
		local pdf_path = filepath:gsub("%.typ$", ".pdf")
		vim.system({ "xdg-open", pdf_path })
	else
		print("not typst")
	end
end, {})

vim.keymap.set("n", "<leader>to", ":OpendPdf <CR>", { desc = "Open current file if it's typst" })

vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		local selected = vim.fn.complete_info({ "selected" }).selected

		if selected == -1 then
			return "<C-n><C-y>"
		else
			return "<C-y>"
		end
	else
		return "<Tab>"
	end
end, { expr = true, replace_keycodes = true, desc = "Accept completion with Tab" })
