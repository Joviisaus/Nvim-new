if vim.g.neovide then
    vim.g.neovide_transparency = 0.8
    vim.g.transparecy = 0

    vim.g.linespace = 0

    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_refresh_rate_idle = 5

    vim.g.neovide_confirm_quit = true

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5

    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_fullscreen = true

    vim.g.neovide_cursor_animation_length = 0.15

    vim.g.neovide_cursor_vfx_particle_lifetime = 1.8
    vim.g.neovide_cursor_vfx_particle_speed = 18.0
    vim.g.neovide_cursor_vfx_particle_density = 14.0

    vim.g.neovide_cursor_antialiasing = true

    vim.g.neovide_cursor_smooth_blink = false

    vim.g.neovide_cursor_vfx_mode = "sonicboom"

    vim.g.neovide_cursor_animate_in_insert_mode = true

    vim.g.neovide_touch_deadzone = 6.0
    -- vim.g.neovide_profiler = true
    vim.g.neovide_cursor_antialiasing = true

    vim.g.neovide_cursor_unfocused_outline_width = 0.125

    vim.g.neovide_theme = 'tokyonight'

    vim.g.neovide_scroll_animation_length = 0.3


    vim.g.neovide_input_use_logo = true
    vim.g.neovide_window_blurred = true
    vim.g.neovide_scale_factor = 0.8


    function ChangeScaleFactor(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end

    vim.api.nvim_set_keymap('n', '<D-=>', ':lua ChangeScaleFactor(1.25)<CR>', { noremap = true, silent = true, expr = true })
    vim.api.nvim_set_keymap('n', '<D-->', ':lua ChangeScaleFactor(1/1.25)<CR>', { noremap = true, silent = true, expr = true })

    vim.g.neovide_remember_window_size = true



end
