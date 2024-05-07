# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gvioli/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/gvioli/.fzf/bin"
fi

eval "$(fzf --zsh)"
