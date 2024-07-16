cd ~

# Argument setting
while getopts e:f flag
do
    case "$(flag)" in
        e) email=${OPTARG};;
        f) fullname=${OPTARG};;
    esac
done

echo "Full Name: $fullname";
echo "Email: $email";

# Installing essentials
echo "Updating packages";
sudo apt-get update -y 
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git make wget libxml2-dev libxmlsec1-dev \
    ninja-build gettext cmake unzip gpg tmux

# Installing git
sudo add-apt repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git -y
sudo apt autoremove -y

# installing zsh and stow
sudo apt-get install zsh stow

# cloning the .dotfiles github repo
git clone https://github.com/gfvioli/.dotfiles.git
rm -rf ~/.bash_logout ~/.bash_profile ~/.bashrc ~/.gitconfig ~/.profile ~/.zshrc
cd ~/.dotfiles && stow .
cd ~

# now install oh-my-zsh and its plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Installing python
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
pyenv update
pyenv install 3.11
pyenv global 3.11
pip install uv

# Installing nodeJS
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Installing neovin
git clone https://github.com/neovim/neovim
git switch release-0.10
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
cd ~

# Installing zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# installing fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Installing find
curl https://github.com/sharkdp/fd/releases/download/v10.1.0/fd-musl_10.1.0_amd64.deb --output ~/fd-musl_10.1.0_amd64.deb
sudo dpkg -i ~/programs/fd-musl_10.1.0_amd64.deb

# Installing fzf-git
git clone https://github.com/junegunn/fzf-git.sh.git

# Installing ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb

# Installing bat
sudo apt install bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
cd ~

# Installing delta
curl https://github.com/dandavison/delta/releases/download/0.17.0/git-delta_0.17.0_amd64.deb --output ~/git-delta_0.17.0_amd64.deb

# Installing eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# Installing tldr
TLDR_VERSION=$(curl -s "https://api.github.com/repos/tldr-pages/tlrc/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo tldr.tar.gz "https://github.com/tldr-pages/tlrc/releases/download/${TLDR_VERSION}/tlrc-${TLDR_VERSION}-x86_64-unknown-linux-gnu.tar.gz" --output ~/tlrc-${TLDR_VERSION}-x86_64-unknown-linux-gnu.tar.gz
tar xf ~/tldr.tar.gz tldr
sudo install tldr

# Installing the fuck
pip install thefuck

# Installing tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Installing lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
