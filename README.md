This is a full guide to get a working version of Ubuntu (WSL) from scratch to fully setup.

## Installing essentials 

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


## Installing Python

To setup Python, install it using [pyenv](https://github.com/pyenv/pyenv):
```bash
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
```

To add Python to the path, use the follwing commands
```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```
```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
```
```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zhsrc_profile
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc_profile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc_profile
```

Now restart the shell for the changes to take effect. The just update pyenv:
```bash
pyenv update
```

Then install a python version, currently using version `3.11.9` (latest 3.11). Also expose it to the global context as the default python version (and environment)
```bash
pyenv install 3.11
pyenv global 3.11
```

I'm currently using the UV pip installer now, is a fast python package installer built in Rust.
```bash
pip install uv
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

## CLI tools
This tools are meant to make your terminal much more powerful

### [zoxide](https://github.com/ajeetdsouza/zoxide)
This is a better way to navigate on the terminal. You can install it via the install script
```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.zshrc
echo 'eval "$(zoxide init --cmd cd zsh)"' >> ~/.zshrc
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
FIND_VERSION = $(curl -s "https://api.github.com/repos/sharkdp/fd/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo ~/find.deb "https://github.com/sharkdp/fd/releases/latest/download/fd-musl_${FIND_VERSION}_amd64.deb"
sudo dpkg -i ~/find.deb
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
NOTE: this app is installed under /usr/bin/rg
```bash
RG_VERSION = $(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo ~/ripgrep.deb "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-aarch64-unknown-linux-gnu.tar.gz"
sudo dpkg -i ~/ripgrep.deb
rm -rf ~/ripgrep.deb
```

### [bat](https://github.com/sharkdp/bat)
Better cat, supporting syntax highlighting and git integration. If using Ubuntu > 20.04, but you have to do a symlink since it install as batcat to avoid a conflict
```bash
sudo apt install bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
```

To make tokyonight the default theme for bat use the following commands:
```bash
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
echo 'export BAT_THEME=tokyonight_night' >> ~/.zshrc
```

### [delta](https://github.com/dandavison/delta/)
Download the package from the relases [page](https://github.com/dandavison/delta/releases) then use dpkg -i to install it.
```bash
DELTA_VERSION = $(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo ~/delta.deb "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
sudo dpkg -i ~/delta.deb
rm -rf ~/delta.deb
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

2. Install eza via:
```bash
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
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
This is a better version of man pages. Make sure to install the rust GNU based binary for better performance, install following the commands
```bash
TLDR_VERSION=$(curl -s "https://https://api.github.com/repos/tldr-pages/tlrc/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo ~/tldr.tar.gz "https://github.com/tldr-pages/tlrc/releases/download/v${TLDR_VERSION}/tlrc-v${TLDR_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
tar xf ~/tldr.tar.gz
sudo install tldr /usr/local/bin
rm -rf ~/tldr.tar.gz
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


### [Quarto](https://github.com/quarto-dev/quarto-cli)

Open source scientific and technical publishing system, to mix markdown and code. Also helps with jupyter notebook-like development inside neovim.

```bash
QUARTO_VERSION=$(curl -s "https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') 
curl -Lo ~/quarto.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb"
sudo dpkg -i ~/quarto.deb
rm -rf ~/quarto.deb
```

### [yazi](https://github.com/sxyazi/yazi)

Open source super fast terminal file manager written in Rust.

```bash
YAZI_VERSION=$(curl -s "https://api.github.com/repos/sxyazi/yazi/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo ~/yazi.snap "https://github.com/sxyazi/yazi/releases/download/v${YAZI_VERSION}/yazi-x86_64-unknown-linux-gnu.snap"
sudo snap install --dangerous --classic yazi.snap
export PATH=$PATH:/snap/bin
```
