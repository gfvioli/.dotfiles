# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gfvioli/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/gfvioli/.fzf/bin"
fi

source <(fzf --zsh)
