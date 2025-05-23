export XDG_CONFIG_HOME=$HOME/.config
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export CPU_CORES=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
export FZF_DEFAULT_OPTS='--ansi --border=thinblock --preview-window=border-thinblock --color "bg:237,bg+:235,gutter:237,border:238,scrollbar:236" --color "preview-bg:235,preview-border:236,preview-scrollbar:234" --scrollbar "▌▐" --multi --tmux'
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --ignore-case --glob --color always'
export LC_ALL=en_US.UTF-8

export OPENAI_API_KEY='sk-secret-token'
export OPENROUTER_API_KEY='sk-secret-token'

# erlang/elixir stuff
export ERL_AFLAGS="-kernel shell_history enabled"

# asdf version manager stuff
export ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdfrc
export ASDF_DATA_DIR=$HOME/.local/state/asdf
export ASDF_DIR=$HOME/.local/state/asdf
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE=$XDG_CONFIG_HOME/asdf/default-python-packages
export ASDF_GEM_DEFAULT_PACKAGES_FILE=$XDG_CONFIG_HOME/asdf/default-ruby-packages
export ASDF_NPM_DEFAULT_PACKAGES_FILE=$XDG_CONFIG_HOME/asdf/default-node-packages

export PATH="$ASDF_DATA_DIR/shims:$HOME/.local/bin:$PATH"

# Load Rails/Symfony environment variables if present
[ -f $HOME/.rails.env ] && source $HOME/.rails.env
[ -f $HOME/.symfony.env ] && source $HOME/.symfony.env

# load autojump if present
if type "autojump" > /dev/null; then
  . /usr/share/autojump/autojump.zsh
fi
