return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      transparent_mode = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    })

    vim.cmd.colorscheme("rose-pine")
  end
}
