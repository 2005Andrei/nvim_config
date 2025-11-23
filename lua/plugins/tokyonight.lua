return {
  "folke/tokyonight.nvim",
  lazy = false, -- load immediately
  priority = 1000,
  config = function()
	  require("tokyonight").setup({
		style = "night",
		transparent = false,
		styles = {
		  comments = { italic = true },
		  keywords = { italic = true },
		},
	  })

	  vim.cmd.colorscheme("tokyonight")
  end,
}
