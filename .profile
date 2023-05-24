export PATH=$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export FZF_DEFAULT_OPTS='--ansi --bind "tab:down,btab:up"'
export FZF_DEFAULT_COMMAND='/usr/lib/cargo/bin/fd --type f --hidden --ignore-case --glob --color always'

# Wayland & GTK apps settings
export GDK_SCALE=1
export GDK_DPI_SCALE=0.6

export CHAT_GPT_KEY='sk-secret-token'

# asdf version manager stuff
export ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdfrc
export ASDF_DIR=$HOME/.local/share/asdf
export ASDF_DATA_DIR=$HOME/.local/state/asdf
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE=$XDG_CONFIG_HOME/asdf/default-python-packages
export ASDF_GEM_DEFAULT_PACKAGES_FILE=$XDG_CONFIG_HOME/asdf/default-ruby-packages

if [ -f $ASDF_DIR ]; then
  . $ASDF_DIR/asdf.sh
fi

# Load Rails/Symfony environment variables if present
[ -f $HOME/.rails.env ] && source $HOME/.rails.env
[ -f $HOME/.symfony.env ] && source $HOME/.symfony.env

# load autojump if present
if type "autojump" > /dev/null; then
  . /usr/share/autojump/autojump.sh
fi
