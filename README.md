This is a full guide to get a working version of Ubuntu (WSL) from scratch to fully setup while using standard linux commands. At the bottom I have the setup using Nix Home-Manager. 

## Installing essentials 
This are the most essential libraries to get started.
```bash
sudo apt-get update
sudo apt install \
    build-essential \
    curl \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils \
    zlib1g-dev
```

### Git
Now install git
```bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git -y
```

To setup up the user.name and email in git:
```bash
git config --global user.name "Gian Violi"
git config --global user.email "gfvioli@gmail.com"
```

Then I can clone my dotfiles repo into my `$HOME` directory
```bash
git clone git@github.com/gfvioli/dotfiles.git
```

Once I have cloned the repo, I can use stow to populate all my configuration files. \
:warning: WARNING: This can fail if you have conflicting files, such as `~/.bashrc` which is there by default, my advice is to delete the conflict and the populate with stow.
```bash
stow .
```
This would make all configurations automatically, but since I needs to still install almost all packages, I'll keep the configuration instructions as part of the installation of all packages.
Recommendation would be to just install all packages following the instructions and skip configuration for stow to make its magic when all its installed

Now we can install a few zsh-plugins  to make the experience much nicer

## Installing and configuring zsh

Now let's install zsh as the default shell:
```bash
sudo apt-get install zsh
```

Now install ohmyzsh, at the end of the installation enter `y` to make zsh the default terminal
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Dotfiles
I keep my dotfiles on a github [repo](https://github.com/gfvioli/dotfiles) 

To use the properly, I need to install [GNU Stow](https://www.gnu.org/software/stow/)
```bash
sudo apt-get install stow
```


### Powerlevel10k
First, we need to clone the repo:
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Now open the `.zshrc` file and change set the theme to `powerlevel10k`
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Once you source the file, the configurator will auto-start. Here's the setup I use:
- First check that the nerd font is working by doing the checks the configurator ask
- Promp style: lean
- Character set: Unicode
- Prompt Colors: 256 bit
- Show current time: 24-hour format
- Prompt Height: Two lines
- Prompt Connection: Dotted
- Prompt Frame: Full
- Connection and Frame Color: Lightest
- Prompt Spacing: Compact
- Icons: Many Icons
- Prompt Flow: Concise
- Enable Transient Prompt: Yes
- Instant Prompt Mode: Verbose

### [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions). 
Last time I checked, the instructions were:
1. Clone the repo into the zsh plugins folder 
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
2. Add the plugin to the oh-my-zsh plugin list (inside `~/.zshrc`):
```bash
plugins=(... zsh-autosuggestions)
```

### [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
Last time I checked, the instructions were:
1. Clone the repo into the zsh plugins folder 
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
2. Add the plugin to the oh-my-zsh plugin list (inside `~/.zshrc`):
```bash
plugins=(... zsh-syntax-highlighting)
```

### Web-search
Just add `web-search` to the list of oh-my-zsh plugins on `~/.zshrc`


## Installing Python using [uv](https://docs.astral.sh/uv/)

uv is an extremly fast Python package and project manager, written in rust. Install it using;;

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

It's also needed to install python3-venv for a general environment, tools like ruff and pyright depend on this.
```bash
sudo apt install python3-venv
```

## Installing NodeJS
You need to install NodeJS for pyright and prettier work later. For it you need to add the repository to the sources list before `sudo apt install`
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```

## [Neovim](https://github.com/neovim/neovim)
I like to install Neovim early in the process because going forwards, there will be multiple times where the `~/.zshrc` file requires modfication. Thus it will be easier to do with your neovim config already done.

### Pre-requisites
In order to have the pre-requisites installed, you need to run the following commands
```bash
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
```

### Installing Neovim
1. Make sure you are in the branch of the release you want to build. 
```bash 
git clone https://github.com/neovim/neovim
```
2. This will take a while as it generating the wheel to install neovim. 
```bash
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
```
3. Install the wheel
```bash
sudo make install
```
4. If step 3 didn't work, you can use this alternative to ensure clean removal of installed files. 
```bash
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
```

## Installing [Rust](https://www.rust-lang.org/)

I recommend installing Rust not only because is an amaizing programming language but also because most of the following tools can be installed using cargo
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
### Installing [sccache](https://github.com/mozilla/sccache) 
The first thing to do after installing rust (and cargo) is to install [sccache](https://github.com/mozilla/sccache) to speed up the compiling of rust binaries.
```bash
cargo instal sccache
```

Then you need to add the wrapper into your `~/.zshrc` file:
```bash
export RUSTC_WRAPPER=sccache
```

You can verify sccache installed succesfully using:
```bash
sccache --show-stats
```

Now to install all cargo tools in one go you can use the following command
```bash
cargo install zoxide 
```

## CLI tools
This tools are meant to make your terminal much more powerful

### [zoxide](https://github.com/ajeetdsouza/zoxide)
This is a better way to navigate on the terminal. You can install it via the install script
```bash
cargo install zoxide fd-find ripgrep git-delta eza tlrc mcprocs speedtest-rs zellij irust
cargo install --locked bat yazi-fm yazi-cli nu
```

### [fzf](https://github.com/junegunn/fzf)
A fuzzy finder for general puprose command line utilities
Install using the install script, say yes at all 3 questions. The scripts adds everything to your path
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

I have made my own theme for fzf. You can use it by adding this lines to `~/.zshrc`
```bash
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
```

Alternatively, you can create your own theme using [the fzf theme generator](https://vitormv.github.io/fzf-themes/)

### [find](https://github.com/sharkdp/fd)
Is a simple, fast and user-friendly aternative to find.
```bash
cargo install fd-find
```

Once installed, you use this commands to use fzf
```bash
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
```

### [fzf-git](https://github.com/junegunn/fzf-git.sh)
Really nice scrip to look for git related things (commits, hashes, files and more) with fzf.
To install:
1. Navigate to your home directory `cd ~`
2. Clone the repo 
```bash
git clone https://github.com/junegunn/fzf-git.sh.git
```
3. Open `~/.zhsrc` and add
```bash
source ~/fzf-git.sh/fzf-git.sh
```
4. Save and in the terminal run `source ~/.zshrc`


### [lazygit](https://github.com/jesseduffield/lazygit)
Really nice TUI for git operations, particularly useful for complex git commands.
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf ~/lazygit ~/lazygit.tar.gz
```

### [ripgrep](https://github.com/BurntSushi/ripgrep)
This allows for Live Grep, needed for telescope. 
NOTE: this app is installed under the alias rg, to check it please use `which rg`.
```bash
cargo install ripgrep
```

### [bat](https://github.com/sharkdp/bat)
Better cat, supporting syntax highlighting and git integration.
```bash
cargo install bat --locked
```

To make tokyonight the default theme for bat use the following commands:
```bash
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
bat cache --build
echo 'export BAT_THEME=tokyonight_night' >> ~/.zshrc
```

### [delta](https://github.com/dandavison/delta/)
You can install delta using cargo:
```bash
cargo install git-delta
```

Once done, add this to your `.gitconfig`
```bash
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true # use n and N to move between diff sections
    side-by-side = true

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

### [eza](https://github.com/eza-community/eza)
Better ls, to install it.

1. Make sure you have the `gpg`, if not, install it via:
```bash
sudo apt update
sudo apt install -y gpg
```

2. Install eza via cargo:
```bash
cargo install eza
```

My defult eza command is achieved by adding the following command to `~/.zshrc`
```bash
alias ls="eza --color=always --git --icons=always --no-time --no-user --no-permissions"
```

To setup fzf preview to use eza for ls and bat iso cat, add this to `.zshrc`
```bash
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
```

### [tldr](https://github.com/tldr-pages/tldr)
This is a better version of man pages, you can install it using cargo
```bash
cargo install tlrc
```

### [The Fuck](https://github.com/nvbn/thefuck)
This is an autocorrect engine for when you make a typo on a command line.
```bash
pip install thefuck
echo 'eval $(thefuck --alias fk)' >> ~/.zshrc
```

### [tmux](https://github.com/tmux/tmux)
Terminal multiplexer: it enables a numbers of terminals to be created, accessed and controlled from a single screen.
```bash
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

My tmux configuration file looks like this:
```bash
# set default terminal
set -g default-terminal "screen-256color"

# set prefix
set -g prefix C-a
unbind C-b
bind-key C-a send-prefix

# set splitting
unbind %
bind | split-window -h

unbind '"'
bind - split-window -v

# source tmux configuration
unbind r
bind r source-file ~/.tmux.conf

# resize windows
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5
bind -r m resize-pane -Z # make panels equal again

# enable mouse
set -g mouse on

# enabling VIM mode for copy 
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection
unbind -T copy-mode-vi MouseDragEnd1Pane # fix copy by draging with mouse

# tmux plugin manager
set -g @plugin 'tmux-plugins/tpm'

# list of tmux plugins
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'jimeh/tmux-themepack'
set -g @plugin 'tmux-plugins/tmux-resurrect' # persis tmux sessions after computer restart
set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions every 15 minutes

# initializing theme
set -g @themepack 'powerline/default/cyan'

# set settings for persisntecy
set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'

run '~/.tmux/plugins/tpm/tpm'
```
After putting the installing tmux and tpm and putting the config in place, open a tmux session and press "Ctrl-a + r" to reload config and "Ctrl-a + I" to install al plugins.

### [yazi](https://github.com/sxyazi/yazi)
Open source super fast terminal file manager written in Rust.

```bash
cargo install --locked yazi-fm yazi-cli
```


### [mcpros](https://github.com/pvolok/mprocs)
A multiplexer for long standing processes and commands.
```bash
cargo install mcprocs
```

### [IRust](https://github.com/sigmaSd/IRust)
A Rust REPL executable to test rust code, you can install using cargo:
```bash
cargo install irust
```

### [speedtest-rs](https://github.com/nelsonjchen/speedtest-rs)
A speedtest CLI client in Rust.
```bash
cargo install speedtest-rs
```

### [Quarto](https://github.com/quarto-dev/quarto-cli)
Open source scientific and technical publishing system, to mix markdown and code. Also helps with jupyter notebook-like development inside neovim.
```bash
QUARTO_VERSION=$(curl -s "https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') 
curl -Lo ~/quarto.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb"
sudo dpkg -i ~/quarto.deb
rm -rf ~/quarto.deb
```
## Other tools I'm currently testing
There are someother tools that I'm considering switching to, this are listed below. Particular warning about NIX is that I'm curretly not sure whether I will eventually fully migrate, while Zellij, Nushell and others I'm commited and going through the learning curve at my own pace.

### [Zellij](https://github.com/zellij-org/zellij)

A terminal multiplexer written in rust. At this moment I'm barely starting my transition to zellij, so is still a bit early for a fully fledged config
```bash
cargo install zelijj
```

## [Nushell](https://github.com/nushell/nushell)
A modern shell written in Rust for the 21st century.
```bash
cargo install --locked nu
```

## :warning: EXPERIMENTAL: Setup using Nix Home-Manager

I haven't finished to set this up so please use with caution and Do Your Own Research (DYOR). In any case if you want to use it I advice agaisnt managing your dotfiles with home-manager and use stow instead, for why see this great [YouTube video](https://www.youtube.com/watch?v=U6reJVR3FfA).
First, install Nix by using the deterministic installer.
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

This wil install the Nix CLI and you'll be able to execute then you can install all the programs and dotfiles by running:

```sh
nix shell nixpkgs#home-manager nixpkgs#gh --command sh -c "\
    gh auth login \
    && gh repo clone gfvioli/.dotfiles -- --depth=1 \
    && home-manager switch --flake ./dotfiles
"
```
