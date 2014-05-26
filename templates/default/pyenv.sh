# Prefer a user pyenv over a system wide install

if [ -s "${HOME}/.pyenv/bin" ]; then
  pyenv_root="${HOME}/.pyenv"
fi

if [ -n "$pyenv_root" ]; then
  export PATH="${pyenv_root}/bin:$PATH"
  eval "$(pyenv init -)"
fi