# Installing pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
