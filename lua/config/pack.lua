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
    { src = "https://github.com/windwp/nvim-ts-autotag" },
    { src = "https://github.com/idossha/matlab.nvim" },
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/nvimdev/dashboard-nvim" },


    -- notifcations
    { src = "https://github.com/rcarriga/nvim-notify" },

    -- typst
    { src = "https://github.com/chomosuke/typst-preview.nvim" },

    -- lsp
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },

    -- telescope
    { src = "http://github.com/aznhe21/actions-preview.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim",          version = "0.1.8" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/LinArcX/telescope-env.nvim" },

    -- dependencies added as normal plugins
    { src = "https://github.com/3rd/image.nvim" },
    { src = "https://github.com/antosha417/nvim-lsp-file-operations" },
    { src = "https://github.com/s1n7ax/nvim-window-picker" },
})

require('notify').setup({})
vim.notify = require('notify')

vim.keymap.set("n", "<leader>b", function()
    local bufs = vim.api.nvim_list_bufs()
    local clean_list = {}


    for _, buf_id in ipairs(bufs) do
        if vim.fn.buflisted(buf_id) == 1 then
            local path = vim.api.nvim_buf_get_name(buf_id)

            if path == "" then
                path = "[no name or sth]"
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


require('vague').setup({
    transparent = true,
    bold = false,
    italic = false
})

require('kanagawa').setup({
    transparent = true,

    overrides = function(colors)
        local theme = colors.theme
        return {
            LineNr = { bg = "none" },
            CursorLineNr = { bg = "none" },
            SignColumn = { bg = "none" },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            NeoTreeNormal = { bg = "none" },
            NeoTreeNormalNC = { bg = "none" },
        }
    end,
})


require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16,
            events = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            },
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress', 'location' },
        lualine_z = {
            {
                "datetime",
                style = "%H:%M"
            }
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}



vim.cmd('colorscheme kanagawa-dragon')


local telescope = require('telescope')
telescope.setup({
    defaults = {
        preview = { treesitter = true },
        color_devicons = true,
        sorting_strategy = "ascending",
        borderchars = {
            "", -- top
            "", -- right
            "", -- bottom
            "", -- left
            "", -- top-left
            "", -- top-right
            "", -- bottom-right
            "", -- bottom-left
        },
        path_displays = { "smart" },
        layout_config = {
            height = 100,
            width = 400,
            prompt_position = "top",
            preview_cutoff = 40,
        }
    }
})
telescope.load_extension("ui-select")

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope Find Files" })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Telescope Find Files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope Live Grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope Help" })
vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = "Telescope Find Files" })
vim.keymap.set('n', '<leader>fe', "<Cmd>Telescope env<CR>", { desc = "env vars" })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "diagnostics" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "keymaps" })

vim.keymap.set('n', '<leader>fl', builtin.git_bcommits, { desc = "git commits" })

require("actions-preview").setup({
    backend = { "telescope" },
    extensions = { "env" },
    telescope = vim.tbl_extend(
        "force",
        require("telescope.themes").get_dropdown(), {}
    )
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

vim.keymap.set('n', "-", "<cmd>Oil<CR>")

require('neo-tree').setup({
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
            highlight = "NeoTreeFileIcon"
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
                added     = "",
                modified  = "",
                deleted   = "✖",
                renamed   = "󰁕",
                untracked = "",
                ignored   = "",
                unstaged  = "󰄱",
                staged    = "",
                conflict  = "",
            }
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
        }
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
        background = { bg = 'none' },
        fill = { bg = 'none' },
        buffer_selected = { bg = 'none', fg = '#fab387' },
        buffer_visible = { bg = 'none', fg = '#a6adc8' },
        close_button = { bg = 'none' },
        close_button_selected = { bg = 'none' },
        close_button_visible = { bg = 'none' },
        duplicate = { bg = 'none' },
        duplicate_selected = { bg = 'none' },
        duplicate_visible = { bg = 'none' },
        error = { bg = 'none' },
        error_selected = { bg = 'none' },
        error_visible = { bg = 'none' },
        hint = { bg = 'none' },
        hint_selected = { bg = 'none' },
        hint_visible = { bg = 'none' },
        indicator_selected = { bg = 'none' },
        indicator_visible = { bg = 'none' },
        info = { bg = 'none' },
        info_selected = { bg = 'none' },
        info_visible = { bg = 'none' },
        modified = { bg = 'none' },
        modified_selected = { bg = 'none' },
        modified_visible = { bg = 'none' },
        numbers = { bg = 'none' },
        numbers_selected = { bg = 'none' },
        numbers_visible = { bg = 'none' },
        offset_separator = { bg = 'none' },
        pick = { bg = 'none' },
        pick_selected = { bg = 'none' },
        pick_visible = { bg = 'none' },
        separator = { bg = 'none' },
        separator_selected = { bg = 'none' },
        separator_visible = { bg = 'none' },
        tab = { bg = 'none' },
        tab_close = { bg = 'none' },
        tab_selected = { bg = 'none' },
        tab_separator = { bg = 'none' },
        tab_separator_selected = { bg = 'none' },
        trunc_marker = { bg = 'none' },
        warning = { bg = 'none' },
        warning_selected = { bg = 'none' },
        warning_visible = { bg = 'none' },
    },
    options = {
        indicator = {
            icon = '',
            style = 'none',
        },
        separator_style = { '', '' },
    },
})

require("typst-preview").setup({
    dependencies_bin = {
        ['tinymist'] = 'tinymist'
    }
})

require("dashboard").setup({
    theme = 'hyper',
    config = {
        week_header = {
            enable = true,
        },
        shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                desc = ' Apps',
                group = 'DiagnosticHint',
                action = 'Telescope app',
                key = 'a',
            },
            {
                desc = ' dotfiles',
                group = 'Number',
                action = 'Telescope dotfiles',
                key = 'd',
            },
        },
    },
})

require("nvim-autopairs").setup({})
require("ibl").setup({})
require("mason").setup({})

require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true
    },
    aliases = {
        ["axaml"] = "xml",
    }
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.lsp.enable({
    "lua_ls", "cssls", "tinymist", "clangd", "ruff", "tailwindcss", "ts_ls", "pyright", "matlab_ls"
})

modes = { "v", "n", "x" }
vim.keymap.set("n", "<leader>e", function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end, { desc = "neotree explorer" })

vim.keymap.set(modes, "<leader>o", function()
    if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd("p")
    else
        vim.cmd.Neotree("focus")
    end
end, { desc = "toggle focus" })


require('matlab').setup({
    executable = '/home/andrei/.local/MATLAB/R2025b/bin/matlab',

    panel_size = 50,
    panel_size_type = 'percentage',
    tmux_pane_direction = 'right',
    tmux_pane_focus = true,

    auto_start = true,
    default_mappings = true,
    minimal_notifications = true,
})
