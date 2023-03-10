export PATH=$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export FZF_DEFAULT_OPTS='--ansi --bind "tab:down,btab:up"'
export FZF_DEFAULT_COMMAND='/usr/lib/cargo/bin/fd --type f --hidden --ignore-case --glob --color always'

# Wayland & GTK apps settings
export GDK_SCALE=1
export GDK_DPI_SCALE=0.6


# Load Rails/Symfony environment variables if present
[ -f $HOME/.rails.env ] && source $HOME/.rails.env
[ -f $HOME/.symfony.env ] && source $HOME/.symfony.env

# initialize pyenv if present
if [ -d "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH";
  export PYENV_ROOT="$HOME/.pyenv"

  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  . $(pyenv root)/completions/pyenv.zsh
fi

# initialize rbenv if present
if [ -d "$HOME/.rbenv" ]; then
  export PATH=$HOME/.rbenv/bin:$PATH;
  export RBENV_ROOT=$HOME/.rbenv;
  eval "$(rbenv init -)";
  . $RBENV_ROOT/completions/rbenv.zsh
fi

# load autojump if present
if type "autojump" > /dev/null; then
  . /usr/share/autojump/autojump.sh
fi
