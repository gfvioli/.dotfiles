-- Pull in the wezterm API
local wezterm = require('wezterm')

-- Preloading the config
local config = {}
if wezterm.config_builder() then
    config = wezterm.config_builder()
end

-- Open maximized
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- Loading my WSLs setup
config.wsl_domains = {
    {
        name = 'WSL:Ubuntu',           -- The name of the domain, must be unique amongts all types of domains, not only WSL.
        distribution = 'Ubuntu-24.04', -- The name of the distribution, needs to match the distribution name that is output by `wsl -l -v`
        default_cwd = '~'
    },
    {
        name = 'WSL:Ubuntu-dev',           -- The name of the domain, must be unique amongts all types of domains, not only WSL.
        distribution = 'Ubuntu-24.04-dev', -- The name of the distribution, needs to match the distribution name that is output by `wsl -l -v`
        default_cwd = '~'
    },
}

config.default_domain = 'WSL:Ubuntu' -- Call your default domain

-- Font settings
config.font = wezterm.font('MesloLGS Nerd Font Mono')
config.font_size = 12

-- General UI configs
config.enable_tab_bar = false -- Prefer multiplexing in TMUX anyway
-- remove top bar for extra real estate, but I can still resize the window
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_close_confirmation = 'NeverPrompt'
config.window_background_opacity = 0
config.win32_system_backdrop = "Tabbed" -- Options are: Disabled (Auto), Acrylic, Mica, Tabbed.
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.keys = {
    { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
}

config.color_scheme = 'TokyoNight'

return config
