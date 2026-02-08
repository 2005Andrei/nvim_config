return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")

    iron.setup({
      config = {
        repl_open_cmd = "vertical botright 60 split",
        repl_definition = {
          python = {
            command = { "uv", "run", "python" },
            format = require("iron.fts.common").bracketed_paste_python
          }
        }
      },
      keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },
      highlight = {
        italic = false
      },
      ignore_blank_lines = true,
    })
  end,
}
