# force copying whichever configs need ton be maintained in windows when using WSL
# WIN_HOME should be maintain in .profile in each individual pc

cp -f .wezterm.lua $WIN_HOME/.wezterm.lua
cp -f .glaze_config.yaml $WIN_HOME/.glzr/glazewm/config.yaml
