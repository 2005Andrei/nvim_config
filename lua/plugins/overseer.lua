return {
  "stevearc/overseer.nvim",
  config = function()
    local overseer = require("overseer")
    overseer.setup({
      task_list = {
        direction = "right",
        min_width = 30,
        default_detail = 1,
        bindings = {
          ["<C-l>"] = "IncreaseDetail",
          ["<C-h>"] = "DecreaseDetail",
          ["["] = "DecreaseWidth",
          ["]"] = "IncreaseWidth",
        },
      },
    })

    overseer.register_template({
      name = "Run with uv",
      builder = function(params)
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "uv", "run", file },
          components = {
            { "on_output_quickfix", set_diagnostics = true },
            "on_result_diagnostics",
            "default",
            { "open_output",        focus = false },
            { "restart_on_save",    paths = { file } },
          },
        }
      end,
      condition = {
        filetype = { "python" },
      },
    })

    vim.keymap.set("n", "<leader>rr", "<cmd>OverseerRun<cr>", { desc = "Run Overseer Task" })
    vim.keymap.set("n", "<leader>ro", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer Window" })
  end,
}
