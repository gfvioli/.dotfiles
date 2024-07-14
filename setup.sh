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
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git make wget libxml2-dev libxmlsec1-dev

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

