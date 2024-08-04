-- Pull in the wezterm API
local wezterm = require('wezterm')

-- Preloading the config
local config = {}
if wezterm.config_builder() then
    config = wezterm.config_builder()
end

-- Loading my WSLs setup
config.wsl_domains = {
    {
        name = 'WSL:Ubuntu',           -- The name of the domain, must be unique amongts all types of domains, not only WSL.
        distribution = 'Ubuntu-24.04', -- The name of the distribution, needs to match the distribution name that is output by `wsl -l -v`
    },
}

config.default_domain = 'WSL:Ubuntu' -- Call your default domain

-- Font settings
config.font = wezterm.font('MesloLGS Nerd Font Mono')
config.font_size = 10

-- General UI configs
config.enable_tab_bar = false        -- Prefer multiplexing in TMUX anyway
config.window_decorations = "RESIZE" -- remove top bar for extra real estate, but I can still resize the window
config.window_background_opacity = 0
config.win32_system_backdrop = "Acrylic"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.color_scheme = 'TokyoNight'

return config
