return {
  "AstroNvim/astrotheme",
  lazy = false,
  priority = 1000,
  config = function()
    require("astrotheme").setup({
      palette = "astrodark",
      background = { -- :h background
        light = "astrolight",
        dark = "astrodark",
      },

      style = {
        transparent = true,
        inactinve = true,
        float = true,
        neotree = true,
        border = true,
        title_invert = true,
        italic_comments = true,
        simple_syntax_colors = true,
      },

      termuigcolors = true, -- toggles if termguicolors are set by astrotheme
      terminal_color = true,

      plugin_default = "auto",

    })
  end,
}
