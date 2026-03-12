vim.g.mapleader = " "

-- Project Navigation
-- vim.keymap.set("n", "<leader>e", vim.cmd.Explore, { desc = "Open Explorer" })

-- Moving Lines (The Primeagen mappings)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Center cursor while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without losing clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize Windows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move lines up/down
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Inserting and Removing newlines
-- vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
-- vim.keymap.set("n", "K", "mzo<Esc>`z", { desc = "Insert new line below and keep cursor position" })

-- Enable completion triggered by <c-x><c-o>
vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- typst open pdf, more info: https://myriad-dreamin.github.io/tinymist/frontend/neovim.html
vim.api.nvim_create_user_command("OpenPdf", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath:match("%.typ$") then
        local pdf_path = filepath:gsub("%.typ$", ".pdf")
        vim.system({ "xdg-open", pdf_path })
    else
        print("not typst dumb ahh")
    end
end, {})

vim.keymap.set("n", "<leader>to", ":OpenPdf <CR>", { desc = "Open current file if it's typst" })
