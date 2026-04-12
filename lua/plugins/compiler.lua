return {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
        { "<C-X>",  "<cmd>CompilerOpen<cr>",          desc = "Open Compiler",           noremap = true, silent = true },
        { "<C-XV>", "<cmd>CompilerToggleResults<cr>", desc = "Toggle Compiler Results", noremap = true, silent = true },
        { "<C-XS>", "<cmd>CompilerStop<cr>",          desc = "Stop Compiler",           noremap = true, silent = true },
        { "<C-XR>", "<cmd>CompilerRedo<cr>",          desc = "Redo Compiler",           noremap = true, silent = true },
    },
}
