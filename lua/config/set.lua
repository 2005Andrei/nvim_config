-- Basic settings
vim.opt.number = true         -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true     -- Highlight current line
vim.opt.wrap = false          -- Don't wrap lines
vim.opt.scrolloff = 10        -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 2        -- Tab width
vim.opt.shiftwidth = 2     -- Indent width
vim.opt.softtabstop = 2    -- Soft tab stop
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true  -- Case sensitive if uppercase in search
vim.opt.hlsearch = false  -- Don't highlight search results
vim.opt.incsearch = true  -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true                      -- Enable 24-bit colors
vim.opt.signcolumn = "yes"                        -- Always show sign column
vim.opt.showmatch = true                          -- Highlight matching brackets
vim.opt.matchtime = 2                             -- How long to show matching bracket
vim.opt.cmdheight = 1                             -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = false                          -- Don't show mode in command line
vim.opt.pumheight = 10                            -- Popup menu height
vim.opt.pumblend = 10                             -- Popup menu transparency
vim.opt.winblend = 0                              -- Floating window transparency
vim.opt.conceallevel = 0                          -- Don't hide markup
vim.opt.concealcursor = ""                        -- Don't hide cursor line markup
vim.opt.lazyredraw = true                         -- Don't redraw during macros
vim.opt.synmaxcol = 200                           -- Syntax highlighting limit

-- Cursor settings
vim.opt.guicursor =
"n-v-c:block,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250,r-cr:hor20,o:hor50,a:Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- System clipboard
vim.opt.clipboard = 'unnamedplus'

-- Hover
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
-- Line diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {})
-- Go to next diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {})
-- Go to previous diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {})
-- List all diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {})
