return {
    'idossha/matlab.nvim',
    ft = 'matlab',
    config = function()
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
    end
}
