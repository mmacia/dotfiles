# Load Rails/Symfony environment variables if present
[ -f $HOME/.rails.env ] && source $HOME/.rails.env
[ -f $HOME/.symfony.env ] && source $HOME/.symfony.env
[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/fzf.zsh

# initialize pyenv if present
if [ -d "$HOME/.pyenv" ]; then
  export PATH=$HOME/.pyenv/bin:$PATH;
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
