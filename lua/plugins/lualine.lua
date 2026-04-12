return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "tokyonight",
            },
            sections = {
                lualine_z = {
                    "location",
                    {
                        "datetime",
                        style = "%H:%M"
                    },
                },
            },
        })
    end,
}
